package com.pingidentity.pingone;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.net.Uri;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.content.FileProvider;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.FirebaseApp;
import com.google.firebase.iid.FirebaseInstanceId;
import com.google.firebase.iid.InstanceIdResult;
import com.pingidentity.pingidsdkv2.NotificationObject;
import com.pingidentity.pingidsdkv2.PingOne;
import com.pingidentity.pingidsdkv2.PingOneSDKError;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;

public class MainActivity extends Activity {
    private static final String TAG = MainActivity.class.getCanonicalName();
    Logger logger = LoggerFactory.getLogger(MainActivity.class);

    private EditText activationCodeInput;
    private AlertDialog alertDialog;

    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        if(intent.hasExtra("PingOneNotification")){
            NotificationObject pingOneNotificationObject = (NotificationObject) intent.getExtras().get("PingOneNotification");
            String title = "Authenticate?";
            String body = null;
            if(intent.hasExtra("title")){
                title = intent.getStringExtra("title");
            }
            if (intent.hasExtra("body")){
                body = intent.getStringExtra("body");
            }
            if(pingOneNotificationObject.isTest()){
                showOkDialog(body);
            }else {
                showApproveDenyDialog(pingOneNotificationObject, title, body);
            }
        }
    }


    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        FirebaseApp.initializeApp(MainActivity.this);
        setContentView(R.layout.activity_main);
        setFcmRegistrationIdToken();
        if(getIntent().hasExtra("PingOneNotification")){
            NotificationObject pingOneNotificationObject = (NotificationObject) getIntent().getExtras().get("PingOneNotification");
            String title = "Authenticate?";
            String body = null;
            if(getIntent().hasExtra("title")){
                title = getIntent().getStringExtra("title");
            }
            if (getIntent().hasExtra("body")){
                body = getIntent().getStringExtra("body");
            }
            if(pingOneNotificationObject.isTest()){
                showOkDialog(body);
            }else {
                showApproveDenyDialog(pingOneNotificationObject, title, body);
            }
        }
        activationCodeInput = findViewById(R.id.activation_code_input);
        final Button buttonPair = findViewById(R.id.button_pair);
        buttonPair.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                buttonPair.setEnabled(false);
                String activationCode = activationCodeInput.getText().toString();
                PingOne.pair(MainActivity.this, activationCode, new PingOne.PingOneSDKCallback() {
                    @Override
                    public void onComplete(@Nullable final PingOneSDKError pingOneSDKError) {
                        if (pingOneSDKError==null) {
                            logger.info("Pairing complete");
                            runOnUiThread(new Runnable() {
                                @Override
                                public void run() {
                                    SharedPreferences.Editor sharedPreferences = getSharedPreferences("InternalPrefs", MODE_PRIVATE).edit();
                                    sharedPreferences.putBoolean("paired", true);
                                    sharedPreferences.apply();
                                    showOkDialog("Device is paired successfully");
                                    buttonPair.setEnabled(true);

                                }
                            });
                        }else{
                            runOnUiThread(new Runnable() {
                                @Override
                                public void run() {
                                    buttonPair.setEnabled(true);
                                    showOkDialog(pingOneSDKError.toString());
                                }
                            });
                        }
                    }
                });
            }
        });
    }

    private String getFcmRegistrationToken() {
        SharedPreferences prefs = getSharedPreferences("InternalPrefs", MODE_PRIVATE);
        return prefs.getString("pushToken", null);

    }

    private boolean getPairingStatus(){
        return getSharedPreferences("InternalPrefs", MODE_PRIVATE).getBoolean("paired", false);
    }

    private void setFcmRegistrationIdToken() {
        FirebaseInstanceId.getInstance().getInstanceId()
                .addOnCompleteListener(new OnCompleteListener<InstanceIdResult>() {
                    @Override
                    public void onComplete(@NonNull Task<InstanceIdResult> task) {
                        if (!task.isSuccessful()) {
                            Log.w(TAG, "getInstanceId failed", task.getException());
                            return;
                        }
                        if(task.getResult()!=null) {
                            // Get new Instance ID token
                            String token = task.getResult().getToken();
                            // Log and toast
                            SharedPreferences.Editor editor = getSharedPreferences("InternalPrefs", MODE_PRIVATE).edit();
                            editor.putString("pushToken", token);
                            editor.apply();

                        }


                    }
                });
    }


    private void showOkDialog(String message){
        new AlertDialog.Builder(MainActivity.this)
                .setMessage(message)
                .setPositiveButton(android.R.string.ok, null)
                .show()
                .getButton(DialogInterface.BUTTON_POSITIVE).setContentDescription(this.getString(R.string.alert_dialog_button_ok));
    }

    private void showApproveDenyDialog(final NotificationObject pingOneNotificationObject, String title, String message){
        /*
         * if another authentication request arrived cancel the previous
         */
        if(alertDialog!=null && alertDialog.isShowing()){
            alertDialog.cancel();
        }
        alertDialog = new AlertDialog.Builder(this)
                .setTitle(title)
                .setMessage(message)
                .setPositiveButton(R.string.approve_button_text, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        pingOneNotificationObject.approve(MainActivity.this, new PingOne.PingOneSDKCallback() {
                            @Override
                            public void onComplete(@Nullable final PingOneSDKError pingOneSDKError) {
                                runOnUiThread(new Runnable() {
                                    @Override
                                    public void run() {
                                        if (pingOneSDKError != null) {
                                            showOkDialog(pingOneSDKError.toString());
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
                        pingOneNotificationObject.deny(MainActivity.this, new PingOne.PingOneSDKCallback() {
                            @Override
                            public void onComplete(@Nullable final PingOneSDKError pingOneSDKError) {
                                runOnUiThread(new Runnable() {
                                    @Override
                                    public void run() {
                                        if (pingOneSDKError != null) {
                                            showOkDialog(pingOneSDKError.toString());
                                        }
                                    }
                                });
                            }
                        });
                    }
                })
                .create();
        alertDialog.show();
        alertDialog.getButton(DialogInterface.BUTTON_POSITIVE).setContentDescription(getString(R.string.button_approve));
        alertDialog.getButton(DialogInterface.BUTTON_NEGATIVE).setContentDescription(getString(R.string.button_deny));
    }

    /*
     * To share log file use this method. The FileProvider for your application_id and
     * PingOne log file is provided by the SDK component.
     */
    private void shareLogFile(Context context){
        /*
         * This is the full path to the PingOne log file
         */
        File file = new File(context.getFilesDir().getAbsolutePath()
                .concat(File.separator)
                .concat("pingone.log"));
        /*
         * Create an URI using FileProvider to make sure it will work on every Android version
         */
        Uri uri = FileProvider.getUriForFile(context, BuildConfig.APPLICATION_ID, file);
        /*
         * Bundle an Uri into Intent and activate it
         */
        Intent sharingIntent = new Intent(Intent.ACTION_SEND);
        sharingIntent.setType("text/*");
        sharingIntent.putExtra(Intent.EXTRA_STREAM, uri);
        /*
         * Set flag to give temporary permission to external app to use your FileProvider
         */
        sharingIntent.setFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
        /*
         * Activate an intent (title is mandatory and configurable)
         */
        startActivity(Intent.createChooser(sharingIntent, "Choose an application"));

    }
}
