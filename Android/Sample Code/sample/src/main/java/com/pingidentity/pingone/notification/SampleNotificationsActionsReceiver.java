package com.pingidentity.pingone.notification;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

import androidx.annotation.Nullable;
import androidx.core.app.NotificationManagerCompat;

import com.pingidentity.pingidsdkv2.NotificationObject;
import com.pingidentity.pingidsdkv2.PingOne;
import com.pingidentity.pingidsdkv2.PingOneSDKError;

import static com.pingidentity.pingone.notification.SampleNotificationsManager.NOTIFICATION_ID_SAMPLE_APP;

public class SampleNotificationsActionsReceiver extends BroadcastReceiver {

    public static final String ACTION_APPROVE = "sample_action_approve";
    public static final String ACTION_DENY = "sample_action_deny";

    @Override
    public void onReceive(Context context, Intent intent) {
        Bundle bundle = intent.getBundleExtra("extra");
        NotificationObject notificationObject = bundle.getParcelable("NotificationObject");

        if (intent.getAction()!=null && intent.getAction().equalsIgnoreCase(ACTION_APPROVE)){

            notificationObject.approve(context, new PingOne.PingOneSDKCallback() {
                @Override
                public void onComplete(@Nullable PingOneSDKError pingOneSDKError) {
                    Log.i("ActionReceiver", "Approve action completed successfully");
                }
            });
        }
        if (intent.getAction()!=null && intent.getAction().equalsIgnoreCase(ACTION_DENY)){

            notificationObject.deny(context, new PingOne.PingOneSDKCallback() {
                @Override
                public void onComplete(@Nullable PingOneSDKError pingOneSDKError) {
                    Log.i("ActionReceiver", "Deny action completed successfully");
                }
            });
        }
        NotificationManagerCompat notificationManager = NotificationManagerCompat.from(context);
        notificationManager.cancel(NOTIFICATION_ID_SAMPLE_APP);
    }
}
