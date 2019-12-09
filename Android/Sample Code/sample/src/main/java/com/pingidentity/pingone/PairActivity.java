package com.pingidentity.pingone;

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
import com.google.firebase.iid.FirebaseInstanceId;
import com.google.firebase.iid.InstanceIdResult;
import com.pingidentity.pingidsdkv2.PingOne;
import com.pingidentity.pingidsdkv2.PingOneSDKError;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;

public class PairActivity extends SampleActivity {
    private static final String TAG = PairActivity.class.getCanonicalName();
    Logger logger = LoggerFactory.getLogger(PairActivity.class);

    private EditText activationCodeInput;


    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_pair);
        setFcmRegistrationIdToken();

        activationCodeInput = findViewById(R.id.activation_code_input);
        final Button buttonPair = findViewById(R.id.button_pair);
        buttonPair.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                buttonPair.setEnabled(false);
                String activationCode = activationCodeInput.getText().toString();
                PingOne.pair(PairActivity.this, activationCode, new PingOne.PingOneSDKCallback() {
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
        new AlertDialog.Builder(PairActivity.this)
                .setMessage(message)
                .setPositiveButton(android.R.string.ok, null)
                .show()
                .getButton(DialogInterface.BUTTON_POSITIVE).setContentDescription(this.getString(R.string.alert_dialog_button_ok));
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
