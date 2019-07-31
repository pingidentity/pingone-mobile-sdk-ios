## Getting started with Android PingOne SDK


1. Download the [PingOne.aar](SDK/PingOne.aar) library file.

2. Make the following changes to your `build.gradle` files in order to add the PingOne SDK component dependency:
	* Open your top-level `build.gradle` file, to add the PingOne SDK component as a dependency. Add the following lines to the `allprojects` node under the `repositories` node:
	
	    ```
	    flatDir {
	        dirs 'libs'
	    }
	    ```
   
    * Create a `libs` folder inside your module’s folder. Copy the PingOne SDK component file `PingOne.aar` into the `libs` folderit. Add the following dependency to the modules that use the PingOne SDK component:

	    ```
	    {
	        implementation fileTree(include: ['*.aar'], dir: 'libs')
	    }
	    ```
   
    *  As the PingOne SDK component is loaded locally, you’ll have to add the PingOne SDK component’s dependencies manually in order to be able to compile and run it. Add these dependencies under the PingOne SDK component dependency:

	    ```
	    implementation 'androidx.appcompat:appcompat:1.0.2'
		
		implementation 'org.slf4j:slf4j-api:1.7.26'
		implementation 'com.github.tony19:logback-android:2.0.0'
		
		implementation 'com.madgag.spongycastle:core:1.58.0.0'
		implementation 'com.madgag.spongycastle:bcpkix-jdk15on:1.58.0.0'
		
		//FireCloud Messaging Services
		implementation 'com.google.firebase:firebase-core:17.0.0'
		implementation 'com.google.firebase:firebase-messaging:19.0.1'
		
		//Google's gSon library to build and parse JSON format
		implementation 'com.google.code.gson:gson:2.8.5'
		
		//nimbus JWT and JOSE tokens library
		implementation group: 'com.nimbusds', name: 'nimbus-jose-jwt', version: '7.0.1'
		
	    ```

3. Register your application with Firebase according to the instructions in the following tutorial: [https://firebase.google.com/docs/android/setup](https://firebase.google.com/docs/android/setup). 

	**Note**: Make sure you insert the `google-services.json` into your project in order to send push notifications.

4. Register your Application ID in PingOne. See [Edit an application](https://documentation.pingidentity.com/pingone/p14cAdminGuide/index.shtml#p1_t_editApplication.html) in the administration guide.


## Implement the PingOne SDK in your code

PingOne SDK utilizes push messaging in order to authenticate end users. PingOne SDK can work side by side within an app that uses push messaging. This page details the steps needed in order to work with push messages in Android. Your application may receive push messages from the PingOne SDK server, and also from other sources. As a result, your implementation of the FirebaseMessagingService will have to differentiate between push messages sent from the PingOne SDK server and other messages, and pass them to the PingOne SDK component for processing.
In your app, add the appropriate section in your androidmanifest.xml file (FCM messaging service), and add the appropriate class.

1. Retrieve the FCM Registration Token Id from the FCM and set it in the PingOne Library by calling `PingOne.setDeviceToken(context,, token, new PingOne.PingOneSDKCallback())`
Make sure you set the device’s FCM registration token before you call `PingOne.pair`, and make sure you update the PingOne SDK Library with the new device token each time it changes.


2. Retrieve the pairing key (see [Pairing keys](/{{pingoneApisPath}}/man/p1_Users/p1_PairingKeys/)) and pair the device to the PingOne servers by calling
`PingOne.pair(context, pairingKey, new PingOne.PingOneSDKCallback())`

3. Implement the PingOne library’s push handling by passing the RemoteMessage received from FCM to the PingOne Library: 

	```
	@Override
	public void onMessageReceived(final RemoteMessage remoteMessage) {
	PingOne.processRemoteNotification(remoteMessage, new PingOne.PingOneNotificationCallback() {
	     	@Override
	     	public void onComplete(@Nullable NotificationObject notificationObject, PingOneSDKError error) {
	        	 if (notificationObject == null){
	           	  //the push is not from PingOne - apply your customized application logic
	       	  }else{
	            	//the object contains two options - approve and deny - present them to the user             
	     	}
	 });
	}
	```

4. The NotificationObject received in PingOneNotificationCallback contains the “approve” and “deny” methods. Present them to the user according to your UX.

## Sample application methods with comments

### Sample messaging service

```
/*
* This is where you will receive FCM messages
*/
public class SampleMessagingService extends FirebaseMessagingService {

   @Override
   public void onMessageReceived(RemoteMessage remoteMessage) {
       PingOne.processRemoteNotification(remoteMessage, new PingOne.PingOneNotificationCallback() {
           @Override
           public void onComplete(@Nullable NotificationObject pingOneNotificationObject, PingOneSDKError error) {
               if (pingOneNotificationObject == null){
                   //the push is not from PingOne  - apply your customized application logic
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
    * is initially generated, so this is where you would retrieve the token.
    */
   @Override
   public void onNewToken(String token) {
       // If you want to send messages to this application instance or
       // manage this app’s subscriptions on the server side, send the
       // Instance ID token to your app server.
       PingOne.setDeviceToken(this, token, new PingOne.PingOneSDKCallback() {
           @Override
           public void onComplete(@Nullable PingOneSDKError pingOneSDKError) {
 
           }
       });
   }


/**
Optional
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
```


### Share log file

```
/*
* To share the log file, use this method. The FileProvider for your application_id and
* PingOne log file are provided by the SDK component.
*/
private void shareLogFile(Context context){
   /*
    * This is the full path to the PingOne log file
    */
   File file = new File(context.getFilesDir().getAbsolutePath()
           .concat(File.separator)
           .concat("pingone.log"));
   /*
    * Create a URI using FileProvider to make sure it will work on every Android version
    */
   Uri uri = FileProvider.getUriForFile(context, BuildConfig.APPLICATION_ID, file);
   /*
    * Bundle a URI into Intent and activate it
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
```


