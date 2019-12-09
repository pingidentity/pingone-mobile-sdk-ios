package com.pingidentity.pingone;

import android.content.Intent;
import android.util.Log;

import androidx.annotation.Nullable;
import androidx.lifecycle.Lifecycle;
import androidx.lifecycle.ProcessLifecycleOwner;

import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.messaging.RemoteMessage;
import com.pingidentity.pingidsdkv2.NotificationObject;
import com.pingidentity.pingidsdkv2.PingOne;
import com.pingidentity.pingidsdkv2.PingOneSDKError;
import com.pingidentity.pingone.notification.SampleNotificationsManager;

import org.json.JSONException;
import org.json.JSONObject;

/*
 * This is where you will receive FCM messages
 */
public class SampleMessagingService extends FirebaseMessagingService {

    @Override
    public void onMessageReceived(final RemoteMessage remoteMessage) {
        PingOne.processRemoteNotification(remoteMessage, new PingOne.PingOneNotificationCallback() {
            @Override
            public void onComplete(@Nullable NotificationObject pingOneNotificationObject, PingOneSDKError error) {
                if (pingOneNotificationObject == null){
                    //the push is not from PingOne  - handle it your way
                }else if(pingOneNotificationObject.isTest()){
                    //this is test push. You can choose to do nothing.
                    /*
                     * if application is in foreground process the push in activity
                     */
                    if (ProcessLifecycleOwner.get().getLifecycle().getCurrentState() == Lifecycle.State.RESUMED) {
                        Log.i("SampleMessagingService", "Test push received");
                    }else {
                        /*
                         * if the application is in the background build and show Notification
                         */
                        //the object contains two options - approve and deny - present them to the user
                        Intent handleNotificationObjectIntent = new Intent(SampleMessagingService.this, SampleActivity.class);
                        handleNotificationObjectIntent.addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP);
                        handleNotificationObjectIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                        //optional - parse title and body of the push notification
                        parseTitleAndBody(remoteMessage, handleNotificationObjectIntent);
                        handleNotificationObjectIntent.putExtra("PingOneNotification", pingOneNotificationObject);

                        SampleNotificationsManager sampleNotificationsManager = new SampleNotificationsManager(SampleMessagingService.this);
                        sampleNotificationsManager.buildAndSendNotification(handleNotificationObjectIntent);
                    }
                }else{
                    //the object contains two options - approve and deny - present them to the user
                    Intent handleNotificationObjectIntent = new Intent(SampleMessagingService.this, SampleActivity.class);
                    handleNotificationObjectIntent.addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP);
                    handleNotificationObjectIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                    //optional - parse title and body of the push notification
                    parseTitleAndBody(remoteMessage, handleNotificationObjectIntent);
                    handleNotificationObjectIntent.putExtra("PingOneNotification", pingOneNotificationObject);

                    /*
                     * if application is in foreground process the push in activity
                     */
                    if (ProcessLifecycleOwner.get().getLifecycle().getCurrentState() == Lifecycle.State.RESUMED) {

                        startActivity(handleNotificationObjectIntent);
                    }else {
                        /*
                         * if the application is in the background build and show Notification
                         */
                        SampleNotificationsManager sampleNotificationsManager = new SampleNotificationsManager(SampleMessagingService.this);
                        sampleNotificationsManager.buildAndShowActionsNotification(handleNotificationObjectIntent);
                    }


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

    /**
     * Parse the "aps" part of the RemoteMessage to get notifications' title and body
     * @param remoteMessage
     * @param intent
     */
    private void parseTitleAndBody(RemoteMessage remoteMessage, Intent intent){
        if(remoteMessage.getData().containsKey("aps")){
            try {
                JSONObject jsonObject = new JSONObject(remoteMessage.getData().get("aps"));
                intent.putExtra("title", ((JSONObject)jsonObject.get("alert")).get("title").toString());
                intent.putExtra("body", ((JSONObject)jsonObject.get("alert")).get("body").toString());
            } catch (JSONException e) {
                e.printStackTrace();
            }
        }
    }

}
