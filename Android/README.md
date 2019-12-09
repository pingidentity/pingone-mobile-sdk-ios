## Set up a mobile app using the PingOne SDK sample code

### Prerequisites

Prepare the FCM push messaging mandatory data from Firebase developers console:

* Server key
* Package name
* google-services.json

Refer to: [Add Firebase to your Android project](https://firebase.google.com/docs/android/setup).

### Configure FCM push messaging on the PingOne Portal

#### FCM Push Notification:

Add the google-services.json retrieved from the Firebase developers console to your project.

When configuring your PingOne SDK application in the PingOne admin web console (**Connections > Applications > {NATIVE application} > Edit > Authenticator**), you should fill in the Package Name and the Server Key. See [Edit an application](https://documentation.pingidentity.com/pingone/p14cAdminGuide/index.shtml#p1_t_editApplication.html) in the administration guide.



#### Add the PingOne SDK component into your existing project

1. Download the [PingOne.aar](SDK/PingOne.aar) library file.

2. Make the following changes to your `build.gradle` files in order to add the PingOne SDK component dependency:
	* Open your top-level `build.gradle` file, to add the PingOne SDK component as a dependency. Add the following lines to the `allprojects` node inside the `repositories` node:

	    ```
	    flatDir {
	        dirs 'libs'
	    }
	    ```

    * Create a `libs` folder inside your module’s folder. Copy the PingOne SDK component file `PingOne.aar` into the `libs` folder. Add the following dependency to the modules that use the PingOne SDK component:

	    ```
	    {
	        implementation fileTree(include: ['*.aar'], dir: 'libs')
	    }
	    ```

    *  As the PingOne SDK component is loaded locally, you’ll have to add the PingOne SDK component’s dependencies manually in order to be able to compile and run it. Add these dependencies under the PingOne SDK component dependency:

		```
	    implementation 'androidx.appcompat:appcompat:1.1.0'

		implementation 'org.slf4j:slf4j-api:1.7.26'
		implementation 'com.github.tony19:logback-android:2.0.0'

		implementation 'com.madgag.spongycastle:core:1.58.0.0'
		implementation 'com.madgag.spongycastle:bcpkix-jdk15on:1.58.0.0'

		//FireCloud Messaging Services
		implementation 'com.google.firebase:firebase-core:17.0.0'
		implementation 'com.google.firebase:firebase-messaging:19.0.1'

		//Google's gSon library to build and parse JSON format
		implementation 'com.google.code.gson:gson:2.8.5'

		//The jose.4.j library is an open source (Apache 2.0) implementation of JWT and the JOSE specification suite
 		implementation 'org.bitbucket.b_c:jose4j:0.6.5'
```


### Pairing

To manually pair the device, call the following method with your pairing key:

```java
PingOne.pair(context, pairingKey, new PingOne.PingOneSDKCallback())
```

To pair the device using OpedID Connect (automatic pairing):

1. call this function to get the PingOne SDK mobile payload:
```java
public static String generateMobilePayload(Context context);
```
2. pass the received mobile payload on the OIDC request as the value of query param: `mobilePayload`
3. call this function with the ID token after the OIDC authentication completes:
```java
public static void processIdToken(String idToken, PingOnePairingCallback callback);
```

### Working with push messages in Android

PingOne SDK utilizes push messaging in order to authenticate end users. PingOne SDK can work side by side within an app that uses push messaging. This page details the steps needed in order to work with push messages in Android. Your application may receive push messages from the PingOne SDK server, and also from other sources. As a result, your implementation of the FirebaseMessagingService will have to differentiate between push messages sent from the PingOne SDK server and other messages, and pass them to the PingOne SDK component for processing.
In your app, add the appropriate section in your androidmanifest.xml file (FCM messaging service), and add the appropriate class.


#### Register device token on PingOne server

 Retrieve the FCM Registration Token Id from the FCM and set it in the PingOne Library by calling 	
 ```java
PingOne.setDeviceToken(context, token, new PingOne.PingOneSDKCallback())
```
Make sure you set the device’s FCM registration token before you call `PingOne.pair`, and make sure you update the PingOne SDK Library with the new device token each time it changes.

### Handling Push Notifications

Implement the PingOne library’s push handling by passing the RemoteMessage received from FCM to the PingOne Library.
PingOne SDK will only handle push notifications which were issued by the PingOne SDK server. For other push notifications, `PingOneSDKError` with the code `10002, unrecognizedRemoteNotification` will be returned.

```java
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
	}
    });
}
```

### PingOne Mobile SDK sample app

The PingOne Mobile SDK bundle provides a sample app that includes all the basic flows in order to help you get started.


### Share log file

```java
/*
* Call this method if you want to share the PingOne SDK logs with the PingOne support team.
* The FileProvider for your application_id and PingOne log file are provided by the SDK component.
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
