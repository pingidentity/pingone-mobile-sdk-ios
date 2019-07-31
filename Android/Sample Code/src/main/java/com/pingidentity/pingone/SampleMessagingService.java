package com.pingidentity.pingone;

import android.content.Intent;

import androidx.annotation.Nullable;

import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.messaging.RemoteMessage;
import com.pingidentity.pingidsdkv2.NotificationObject;
import com.pingidentity.pingidsdkv2.PingOne;
import com.pingidentity.pingidsdkv2.PingOneSDKError;

public class SampleMessagingService extends FirebaseMessagingService {

    @Override
    public void onMessageReceived(RemoteMessage remoteMessage) {
        PingOne.processRemoteNotification(remoteMessage, new PingOne.PingOneNotificationCallback() {
            @Override
            public void onComplete(@Nullable NotificationObject pingOneNotificationObject, PingOneSDKError error) {
                if (pingOneNotificationObject == null){
                    //the push is not from PingOne For Customer - handle it your way
                }else{
                    //the object contains two options - approve and deny - present them to the user
                    Intent handleNotificationObjectIntent = new Intent(SampleMessagingService.this, MainActivity.class);
                    handleNotificationObjectIntent.addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP);
                    handleNotificationObjectIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                    handleNotificationObjectIntent.putExtra("PingOneNotification", pingOneNotificationObject);
                    startActivity(handleNotificationObjectIntent);

                }
            }
        });

    }

    /**
     * Called if InstanceID token is updated. This may occur if the security of
     * the previous token had been compromised. Note that this is called when the InstanceID token
     * is initially generated so this is where you would retrieve the token.
     */
    @Override
    public void onNewToken(String token) {
        // If you want to send messages to this application instance or
        // manage this apps subscriptions on the server side, send the
        // Instance ID token to your app server.
        PingOne.setDeviceToken(this, token, new PingOne.PingOneSDKCallback() {
            @Override
            public void onComplete(@Nullable PingOneSDKError pingOneSDKError) {

            }
        });
    }
}
