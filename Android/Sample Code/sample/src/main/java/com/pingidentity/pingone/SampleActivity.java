package com.pingidentity.pingone;

import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;

import com.pingidentity.pingidsdkv2.NotificationObject;
import com.pingidentity.pingidsdkv2.PingOne;
import com.pingidentity.pingidsdkv2.PingOneSDKError;

public class SampleActivity extends AppCompatActivity {
    AlertDialog alertDialog;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
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
    }

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

    private void showOkDialog(String message){
        new AlertDialog.Builder(SampleActivity.this)
                .setMessage(message)
                .setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        finish();
                    }
                })
                .show()
                .getButton(DialogInterface.BUTTON_POSITIVE).setContentDescription(this.getString(R.string.alert_dialog_button_ok));
    }

    private void showApproveDenyDialog(final NotificationObject pingOneNotificationObject, String title, String body){
        if(alertDialog!=null && alertDialog.isShowing()){
            alertDialog.cancel();
        }
        alertDialog = new AlertDialog.Builder(this)
                .setTitle(title==null?"Authenticate?":title)
                .setMessage(body==null?"":body)
                .setPositiveButton(R.string.approve_button_text, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        pingOneNotificationObject.approve(SampleActivity.this, "user", new PingOne.PingOneSDKCallback() {
                            @Override
                            public void onComplete(@Nullable final PingOneSDKError pingOneSDKError) {
                                runOnUiThread(new Runnable() {
                                    @Override
                                    public void run() {
                                        if (pingOneSDKError != null) {
                                            showOkDialog(pingOneSDKError.toString());
                                        }else{
                                            finish();
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
                        pingOneNotificationObject.deny(SampleActivity.this, new PingOne.PingOneSDKCallback() {
                            @Override
                            public void onComplete(@Nullable final PingOneSDKError pingOneSDKError) {
                                runOnUiThread(new Runnable() {
                                    @Override
                                    public void run() {
                                        if (pingOneSDKError != null) {
                                            showOkDialog(pingOneSDKError.toString());
                                        }else{
                                            finish();
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
}
