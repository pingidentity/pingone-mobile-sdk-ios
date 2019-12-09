package com.pingidentity.pingone;

import android.app.PendingIntent;
import android.content.DialogInterface;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;

import com.pingidentity.pingidsdkv2.PairingObject;
import com.pingidentity.pingidsdkv2.PingOne;
import com.pingidentity.pingidsdkv2.PingOneSDKError;

import net.openid.appauth.AppAuthConfiguration;
import net.openid.appauth.AuthorizationException;
import net.openid.appauth.AuthorizationRequest;
import net.openid.appauth.AuthorizationResponse;
import net.openid.appauth.AuthorizationService;
import net.openid.appauth.AuthorizationServiceConfiguration;
import net.openid.appauth.ResponseTypeValues;
import net.openid.appauth.TokenResponse;
import net.openid.appauth.browser.BrowserBlacklist;
import net.openid.appauth.browser.Browsers;
import net.openid.appauth.browser.VersionRange;
import net.openid.appauth.browser.VersionedBrowserMatcher;

import java.util.HashMap;
import java.util.Map;

/*
 * This is sample OIDC Activity which shows how to use the AppAuth open code library
 * to implement login via OpenID Connect protocol.
 */
public class OIDCActivity extends SampleActivity {
    private static final String TAG = "OIDC_Activity";

    private static final String OIDC_ISSUER = "https://auth.pingone.com/1e41d166-8012-4fa2-b755-15cd7c8a03de/as";
    private static final String OIDC_CLIENT_ID = "4a43c047-36f9-4d86-a53e-273a4d28d629";
    private static final String OIDC_REDIRECT_URI = "pingonesdk://sample";
    private static final String OIDC_SCOPE = "openid";


    AuthorizationService authorizationService;
    AlertDialog alertDialog;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_oidc);

        AppAuthConfiguration.Builder appAuthConfigurationBuilder = new AppAuthConfiguration.Builder();
        /*
         * Need the next string to resolve some bug with Samsung devices
         * where custom tabs browser activity never returns result
         */
        appAuthConfigurationBuilder.setBrowserMatcher(new BrowserBlacklist(
                new VersionedBrowserMatcher(
                        Browsers.SBrowser.PACKAGE_NAME,
                        Browsers.SBrowser.SIGNATURE_SET,
                        true, // when this browser is used via a custom tab
                        VersionRange.atMost("5.3")
                )));
        authorizationService = new AuthorizationService(this, appAuthConfigurationBuilder.build());

        Button oidcButton = findViewById(R.id.button_pair_oidc);
        oidcButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                discoverAndAuthorize();
            }
        });
    }

    @Override
    protected void onResume() {
        super.onResume();

        Log.i(TAG, "onResume triggered");

        AuthorizationResponse resp = AuthorizationResponse.fromIntent(getIntent());
        if(resp!=null){
            Log.i(TAG, "Authorization response retrieved");
            authorizationService.performTokenRequest(resp.createTokenExchangeRequest(), new AuthorizationService.TokenResponseCallback() {
                @Override
                public void onTokenRequestCompleted(@Nullable TokenResponse response, @Nullable AuthorizationException ex) {
                    if(null == response || null==response.idToken){
                        return;
                    }
                    Log.i(TAG, "OpenIDConnect Authorization token retrieved");

                    PingOne.processIdToken(response.idToken, new PingOne.PingOnePairingCallback() {
                        @Override
                        public void onComplete(@Nullable PairingObject pairingObject, @Nullable PingOneSDKError pingOneSDKError) {
                            if(pingOneSDKError!=null){
                                Log.i(TAG, pingOneSDKError.getMessage());
                                return;
                            }
                            if (pairingObject!=null){
                                //should show approve/deny dialogue
                                showApproveDenyDialog(pairingObject);
                            }
                        }
                    });
                }
            });
        }
    }

    /*
     * Discovers server configuration from provided OIDC_ISSUER and sends authorization request
     */
    private void discoverAndAuthorize(){
        AuthorizationServiceConfiguration.fetchFromIssuer(Uri.parse(OIDC_ISSUER), new AuthorizationServiceConfiguration.RetrieveConfigurationCallback() {
            @Override
            public void onFetchConfigurationCompleted(@Nullable AuthorizationServiceConfiguration serviceConfiguration, @Nullable AuthorizationException ex) {
                if(ex!=null){
                    Log.e(TAG, "failed to fetch configuration");
                    ex.printStackTrace();
                    return;
                }
                /*
                 * We need to retrieve from the PingOne SDK an Object called MobilePayload
                 * and add it to the AuthorizationRequest
                 */
                Map<String, String> payload = new HashMap<>();
                String mobilePayload = PingOne.generateMobilePayload(OIDCActivity.this);
                payload.put("mobilePayload", mobilePayload);
                if(serviceConfiguration==null){
                    Log.e(TAG, "failed to fetch configuration");
                    return;
                }

                AuthorizationRequest.Builder authRequestBuilder =
                        new AuthorizationRequest.Builder(
                                serviceConfiguration, // the authorization service configuration
                                OIDC_CLIENT_ID, // the client ID, typically pre-registered and static
                                ResponseTypeValues.CODE, // the response_type value: we want a code
                                Uri.parse(OIDC_REDIRECT_URI)); // the redirect URI to which the auth response is sent

                AuthorizationRequest authRequest = authRequestBuilder
                        .setScope(OIDC_SCOPE)
                        .setAdditionalParameters(payload) //pass the mobile payload to the server
                        .build();

                authorizationService.performAuthorizationRequest(authRequest,
                        createPostAuthorizationIntent());
                authorizationService.dispose();
                finish();
            }
        });
    }

    private PendingIntent createPostAuthorizationIntent(){
        Intent intent = new Intent(this, this.getClass());
        return PendingIntent.getActivity(this, 0, intent, 0);
    }

    /*
     * Overriding the onBackPressed to dispose authorization service correctly
     * to avoid unnecessary error log messages
     */
    @Override
    public void onBackPressed() {
        if(authorizationService!=null){
            authorizationService.dispose();
        }
        super.onBackPressed();
    }

    /*
     * We would like to ask the user for approval of pairing the device
     */
    private void showApproveDenyDialog(final PairingObject pairingObject){
        if(alertDialog!=null && alertDialog.isShowing()){
            alertDialog.cancel();
        }
        alertDialog = new AlertDialog.Builder(this)
                .setTitle("Allow pairing?")
                .setMessage("Do you want to pair this device?")
                .setPositiveButton(R.string.approve_button_text, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        pairingObject.approve(OIDCActivity.this, new PingOne.PingOneSDKCallback() {
                            @Override
                            public void onComplete(@Nullable final PingOneSDKError pingOneSDKError) {
                                runOnUiThread(new Runnable() {
                                    @Override
                                    public void run() {
                                        if (pingOneSDKError != null) {
                                            showOkDialog(pingOneSDKError.toString());
                                        }else{
                                            showOkDialog("Device is paired");
                                        }
                                    }
                                });

                            }
                        });
                    }
                })
                .setNegativeButton(R.string.deny_button_text, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        Toast.makeText(OIDCActivity.this, "Pairing declined", Toast.LENGTH_LONG).show();
                        alertDialog.dismiss();
                    }
                })
                .create();
        alertDialog.show();

        alertDialog.getButton(DialogInterface.BUTTON_POSITIVE).setContentDescription(getString(R.string.button_approve));
        alertDialog.getButton(DialogInterface.BUTTON_NEGATIVE).setContentDescription(getString(R.string.button_deny));

    }

    private void showOkDialog(String message){
        new AlertDialog.Builder(OIDCActivity.this)
                .setMessage(message)
                .setPositiveButton(android.R.string.ok, null)
                .show()
                .getButton(DialogInterface.BUTTON_POSITIVE).setContentDescription(this.getString(R.string.alert_dialog_button_ok));
    }
}
