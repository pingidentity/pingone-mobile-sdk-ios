package com.pingidentity.pingone.notification;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;

import androidx.core.app.NotificationCompat;
import androidx.core.app.NotificationManagerCompat;

import com.pingidentity.pingidsdkv2.NotificationObject;
import com.pingidentity.pingone.R;

import static com.pingidentity.pingone.notification.SampleNotificationsActionsReceiver.ACTION_APPROVE;
import static com.pingidentity.pingone.notification.SampleNotificationsActionsReceiver.ACTION_DENY;

public class SampleNotificationsManager {

    private final String SAMPLE_NOTIFICATION_CHANNEL_ID = "pingOne.sample.channel";
    public static final int NOTIFICATION_ID_SAMPLE_APP = 1003;

    private Context context;
    public SampleNotificationsManager(Context context){
        this.context = context;
        createNotificationChannel(context);
    }

    /*
     * Because you must create the notification channel before posting any notifications on Android 8.0
     * and higher, you should execute this code as soon as your app starts. It's safe to call this
     * repeatedly because creating an existing notification channel performs no operation.
     */
    private void createNotificationChannel(Context context) {
        /*
         * Create the NotificationChannel, but only on API 26+ because
         * the NotificationChannel class is new and not in the support library
         */
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            CharSequence name = context.getString(R.string.channel_name);
            String description = context.getString(R.string.channel_description);
            int importance = NotificationManager.IMPORTANCE_HIGH;
            NotificationChannel channel = new NotificationChannel(SAMPLE_NOTIFICATION_CHANNEL_ID, name, importance);
            channel.setDescription(description);
            /*
             * Register the channel with the system; you can't change the importance
             * or other notification behaviors after this
             */
            NotificationManager notificationManager = context.getSystemService(NotificationManager.class);
            assert notificationManager != null;
            notificationManager.createNotificationChannel(channel);
        }
    }

    public void buildAndSendNotification(Intent notificationIntent){
        NotificationCompat.Builder builder = new NotificationCompat.Builder(context, SAMPLE_NOTIFICATION_CHANNEL_ID);
        builder.setPriority(NotificationCompat.PRIORITY_MAX);
        builder.setSmallIcon(R.mipmap.ic_launcher);
        /*
         * show the notification over the lock screen
         */
        builder.setVisibility(NotificationCompat.VISIBILITY_PUBLIC);
        if(notificationIntent.hasExtra("title")) {
            builder.setContentTitle(notificationIntent.getStringExtra("title"));
        }
        if (notificationIntent.hasExtra("body")){
            builder.setContentText(notificationIntent.getStringExtra("body"));
        }
        //cancel this notification "on-click" as it doesn't have any action items
        builder.setAutoCancel(true);
        Notification newMessageNotification = builder.build();
        NotificationManagerCompat notificationManager = NotificationManagerCompat.from(context);
        notificationManager.notify(1234, newMessageNotification);
    }

    public void buildAndShowActionsNotification(Intent notificationIntent){
        NotificationCompat.Builder builder = new NotificationCompat.Builder(context, SAMPLE_NOTIFICATION_CHANNEL_ID);
        builder.setPriority(NotificationCompat.PRIORITY_MAX);
        builder.setSmallIcon(R.mipmap.ic_launcher);
        /*
         * show the notification over the lock screen
         */
        builder.setVisibility(NotificationCompat.VISIBILITY_PUBLIC);
        if(notificationIntent.hasExtra("title")) {
            builder.setContentTitle(notificationIntent.getStringExtra("title"));
        }
        if (notificationIntent.hasExtra("body")){
            builder.setContentText(notificationIntent.getStringExtra("body"));
        }

        NotificationObject notificationObject = notificationIntent.getParcelableExtra("PingOneNotification");
        /*
         * to pass a custom parcelable via pending intent it is needed to wrap it in Bundle
         * to avoid RuntimeException which may happen on old devices while decoding
         */
        Bundle extra = new Bundle();
        extra.putParcelable("NotificationObject", notificationObject);

        builder.addAction(createDenyAction(extra));
        builder.addAction(createApproveAction(extra));

        Notification newMessageNotification = builder.build();
        NotificationManagerCompat notificationManager = NotificationManagerCompat.from(context);
        notificationManager.notify(NOTIFICATION_ID_SAMPLE_APP, newMessageNotification);
    }

    /*
     * create an action that sends approve intent to the broadcast receiver
     */
    private NotificationCompat.Action createApproveAction(Bundle bundle){
        Intent approveIntent = new Intent(context, SampleNotificationsActionsReceiver.class);
        approveIntent.setAction(ACTION_APPROVE);
        approveIntent.putExtra("extra", bundle);
        /*
         * Very important to set request code and flag, so the PendingIntent
         * will be unique within the system and the bundle containing data will not be lost
         */
        PendingIntent approvePendingIntent = PendingIntent.getBroadcast(
                context,
                1,
                approveIntent,
                PendingIntent.FLAG_UPDATE_CURRENT);

        return new NotificationCompat.Action.Builder(
                0,
                context.getString(R.string.notification_action_approve),
                approvePendingIntent)
                .build();
    }

    /*
     * create an action that sends deny intent to the broadcast receiver
     */
    private NotificationCompat.Action createDenyAction(Bundle bundle){
        Intent denyIntent = new Intent(context, SampleNotificationsActionsReceiver.class);
        denyIntent.setAction(ACTION_DENY);
        denyIntent.putExtra("extra", bundle);
        /*
         * Very important to set request code and flag, so the PendingIntent
         * will be unique within the system and the bundle containing data will not be lost
         */
        PendingIntent denyPendingIntent = PendingIntent.getBroadcast(
                context,
                2,
                denyIntent,
                PendingIntent.FLAG_UPDATE_CURRENT);

        return new NotificationCompat.Action.Builder(
                0,
                context.getString(R.string.notification_action_deny),
                denyPendingIntent)
                .build();
    }
}
