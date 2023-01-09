# PingOne for Customers Mobile SDK

## Overview

PingOne for Customers Mobile SDK is a set of components and services targeted at enabling organizations to include multifactor authentication (MFA) into native applications.
This solution leverages Ping Identity’s expertise in MFA technology, as a component that can be embedded easily and quickly into a new or existing application. The PingOne for Customers Mobile SDK package comprises of the following components:

* The PingOne for Customers Mobile SDK library for iOS applications.
* A sample app example source code for iOS.
* Mobile Authentication Framework for iOS Developers (integrated into the sample app).

Release notes can be found [here](./release-notes.md).

### Documentation

Reference documentation is available for PingOne for Customers Mobile SDK, describing its capabilities, features, installation and setup, integration with mobile apps, deployment and more: 

* [PingOne for Customers Mobile SDK release notes and admin related documentation](https://docs.pingidentity.com/csh?Product=p1&context=p1mfa_c_introduction)
* [PingOne for Customers Mobile SDK developer documentation](https://apidocs.pingidentity.com/pingone/native-sdks/v1/api/#pingone-mfa-native-sdks)

### Content
1. [Set up a mobile app using the PingOne SDK sample code](#setup)
    1. [Prerequisites](#prerequisites)
    2. [Configure iOS push messaging on the PingOne Portal](#configure_push)
    3. [Compatibility](#compatibility)
    4. [Installation](#installation)
        1. [Installing with the Swift Package Manager](#installation_package)
        2. [Manual downloading from the Ping Identity Assets](#installation_manual)
    5. [Working with push messages in iOS](#work_with_push)
    6. [Register device token on PingOne server](#register_device)
    7. [Handling Push Notifications](#handle_push)
        1. [Push Notifications Categories](#push_categories)
    8. [Localization](#localization)
    9. [Kechain Sharing](#kechain_sharing)
2. [PingOne Mobile SDK sample app](#sample_app)
    1. [Pairing](#sample_app_pairing)
    2. [Send logs](#sample_app_send_logs)
    3. [Get one time passcode](#sample_app_otp)
    4. [Disable SDK push notifications](#sample_app_disable_push)
    5. [Authentication via QR code scanning](#sample_app_qr)
3. [Mobile Authentication Framework](#auth_framework)
4. [Migrate from PingID SDK to PingOne SDK](#migrate)
    1. [Manual flow](#migrate_manual)
    2. [Push notification flow](#migrate_push)

<a name="setup"></a>
## 1. Set up a mobile app using the PingOne SDK sample code

<a name="prerequisites"></a>
### 1.1 Prerequisites

Prepare the iOS push messaging mandatory data from Apple Developer portal:

* Key ID
* Team ID
* Token .p8 file
* Bundle ID

Refer to: [Establishing a Token-Based Connection to APNs](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/establishing_a_token-based_connection_to_apns).

<a name="configure_push"></a>
### 1.2 Configure iOS push messaging on the PingOne Portal

#### iOS Push Notification

When configuring your PingOne SDK application in the PingOne admin web console (**Connections > Applications > {NATIVE application} > Edit > Authenticator**), you should upload your .p8 token and fill in the Key ID, Team ID and Bundle ID. See [Edit an application](https://docs.pingidentity.com/bundle/pingone/page/jez1625773795534.html) in the administration guide.

Beginning with iOS 15, users can define focus modes. In a defined focus mode, all notifications are blocked except those from apps that you choose to allow or notifications that are defined as "time-sensitive".

If you want notifications from the app that you are developing with the PingOne Mobile SDK to be defined as "time-sensitive", follow these steps:

* In the Xcode project, select your target -> tap the `Signing & Capabilities` tab -> add the `Time Sensitive Notifications` capability.
* Make sure to update your app Identifier in the Apple developer account to support `Time Sensitive Notifications`.
* After the identifier is updated, you need to update the app provision profiles as well. 

For more information, see the Apple documentation on [managing identifiers](https://developer.apple.com/help/account/manage-identifiers/enable-app-capabilities) and [adding capabilities to your app](https://developer.apple.com/documentation/xcode/adding-capabilities-to-your-app).

<a name="compatibility"></a>
#### 1.3 Compatibility

**Note:** PingOne SDK supports the following software versions:

* Xcode 13 and above.
* iOS 12.0 and above.

<a name="installation"></a>
#### 1.4 Installation

You can use either of the following methods to add the PingOne SDK component to your existing project:

* Install with the Swift Package Manager
* Install from the Ping Identity Assets

<a name="installation_package"></a>
##### 1.4.1 Installing with the Swift Package Manager

1. Select File → Add Packages… in Xcode’s menu bar.
2. Search for the PingOne SDK using the repo's URL: `https://github.com/pingidentity/pingone-mobile-sdk-ios.git`
3. Set the Dependency Rule to `Branch` with value `master`, and make sure that `Add to Project` is set to your project.
4. Select Add Package.
5. Verify that the package was downloaded in your project.

<a name="installation_manual"></a>
##### 1.4.2 Manual downloading from the Ping Identity Assets

1. Download the latest version 1.8.0 [here](https://assets.pingone.com/pingonemobile/ios-sdk/release/PingOneSDK.xcframework.1.8.0.zip).
2. Unzip the PingOneSDK.xcframework zipped file and drag it into your project.
3. In your **Project Navigator**, click on your target, and drag **PingOneSDK.xcframework** to **Frameworks, Libraries, and Embedded Content**.
4. Check the **Copy items if needed** checkbox.

    ![](./img/p1_i_xc11-SDKintegrateIntoIDE.png)

5. Integrate the PingOneSDK component into your code:
	* Import the framework into your application initialization code:<br>`import PingOneSDK`

<a name="work_with_push"></a>
#### 1.5 Working with push messages in iOS

This section details the steps needed in order to work with push messages in iOS:

* Enable **Push Notifications**: Go to your Project Navigator’s **capabilities** tab. Select **Push Notifications > Enable**.
* Enable **Remote Notifications**: Go to your Project Navigator’s **capabilities** tab. Turn on **Background Modes > Remote notifications**.
* Enable **Push Notifications** in your **Apple Developer Account > Certificates, Identifiers & Profiles > Identifiers > Capabilities > Push Notifications > Enable**.
* Enter your app’s **Deployment Details** settings in your **Apple Developer Account > Certificates, Identifiers & Profiles > Identifiers > Your App ID.** These details are now mandatory prerequisites for Apple to register your device for push notifications.

<a name="register_device"></a>
#### 1.6 Register device token on PingOne server

In order to receive push notifications from PingOne SDK, use the following code in your `didRegisterForRemoteNotificationsWithDeviceToken` call, passing the deviceToken as is:

```swift
@objc public static func setDeviceToken(_ deviceToken: Data, type: APNSDeviceTokenType, completionHandler: @escaping (_ error: NSError?) -> Void)
```

<a name="handle_push"></a>
#### 1.7 Handling Push Notifications

PingOne SDK will only handle push notifications which were issued by the PingOne SDK server. For other push notifications, `NSError` with the code `10002, unrecognizedRemoteNotification` will be returned.

The `APNSDeviceTokenType` should be set like this:

```swift
var deviceTokenType : PingOne.APNSDeviceTokenType = .production
#if DEBUG
deviceTokenType = .sandbox
#endif
```

Inside the following AppDelegate method:

```swift
optional func application(_ application: UIApplication,
didReceiveRemoteNotification userInfo: [AnyHashable : Any],
fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void)
```

Call:

```swift
@objc public static func processRemoteNotification(_ userInfo: [AnyHashable : Any], completionHandler: @escaping (_ notificationObject: NotificationObject?, _ error: NSError?) -> Void)
```

and pass it the `userInfo` as is.

<a name="push_categories"></a>
##### 1.7.1 Push Notifications Categories

PingOne SDK uses categories for different notifications. If your app already uses categories, you will need to retrieve the PingOne SDK categories `Set<UNNotificationCategory>`, by calling:    

```swift
@objc public static func getUNNotificationCategories() -> Set<UNNotificationCategory>
```

and add them to your current categories, for example:

```swift
let center  = UNUserNotificationCenter.current()
center.delegate = self
center.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
    if error == nil
    {
        // Registering UNNotificationCategory more than once results in previous categories being overwritten. PingOne provides the needed categories. The developer may add categories.
        UNUserNotificationCenter.current().setNotificationCategories(PingOne.getUNNotificationCategories())
        DispatchQueue.main.async {
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
}
```
**Note:** Once the method `UIApplication.shared.registerForRemoteNotifications()` is called, APNS will send device token that will receive in `didRegisterForRemoteNotificationsWithDeviceToken`. Next, the device token will be passed to the server with the `setDeviceToken` method and then push will be enabled.

<a name="localization"></a>
#### 1.8 Localization

The following keys are returned by the PingOne SDK Remote Notification, with suggested localization:

```swift
"notification.confirm"  = "Approve";
"notification.deny"     = "Deny";
"notification.message"  = "You have a new authentication request.";
"notification.title"    = "New Authentication";
```

**Note:** An example of these keys is provided in the sample app, in the `Localizable.strings` file.

<a name="kechain_sharing"></a>
#### 1.9 Keychain Sharing

**Note:** This step is required only if your app uses Keychain Sharing.
Make sure that the first item on your Keychain Groups is `YOUR_BUNDLE_ID` (your private keychain group). This requirement will ensure that the SDK keychain values are private, and are not shared between apps​:


![](./img/p1_i_SDKkeychainSharing.png)

<a name="sample_app"></a>
## 2. PingOne Mobile SDK sample app

The PingOne Mobile SDK bundle provides a sample app that includes all the basic flows in order to help you get started.

<a name="sample_app_pairing"></a>
### 2.1 Pairing

To manually pair the device, call the following method with your pairing key:

```swift
/// Pair device
///
/// - Parameters:
///   - pairingKey: The `String` value
///   - completionHandler: Will return PairingInfo object containing data about pairing resolution, and NSError in case of an error. Documentation for pairing object error codes: https://apidocs.pingidentity.com/pingone/mobile-sdks/v1/api/#pingone-mobile-sdk-for-ios
@objc public static func pair(_ pairingKey: String, completion: @escaping (_ response: PairingInfo?, NSError?) -> Void)
```

To automatically pair the device using OpenID Connect:

1. call this function to get the PingOne SDK mobile payload:
```swift
@objc public static func generateMobilePayload() throws -> String
```
2. pass the received mobile payload on the OIDC request as the value of query param: `mobilePayload`
3. call this function with the ID token after the OIDC authentication completes:
```swift
@objc public static func processIdToken(_ idToken: String, completionHandler: @escaping (_ pairingObject: PairingObject?, _ error: NSError?) -> Void)
```

<a name="sample_app_send_logs"></a>
### 2.2 Send logs

```swift
// Call this method if you want to send logs to the PingOne support team.
PingOne.sendLogs { (supportId, error) in
    if let supportId = supportId{
        print("Support ID:\(supportId)")
        }
    }
    else if let error = error{
        print("error sending logs: \(error.debugDescription)")
    }
}
```

<a name="sample_app_otp"></a>
### 2.3 Get one time passcode

```swift
/// Get one time passcode object
/// - Parameter completionHandler: OneTimePasscodeData object if available or error
@objc public static func getOneTimePasscode(_ completionHandler: @escaping (_ oneTimePasscodeData: OneTimePasscodeData?, _ error: Error?) -> Void)
```

<a name="sample_app_disable_push"></a>
### 2.4 Disable SDK push notifications

```swift
/// Method that will notify the server not to send push messages to this device. Set to false to disable SDK push notifications.
/// - Parameter allowed: a boolean that will tell the server to send push messages or not. Defaults to `true`.
@objc (allowPushNotifications:) public static func pushNotification(allowed: Bool)
```

<a name="sample_app_qr"></a>
### 2.5 Authentication via QR code scanning

PingOne SDK provides an ability to authenticate via scanning the QR code (or typing the code manually). 
The authCode should be passed to the PingOne SDK as is or inside a URI. 
For example: "7F45HGF5", "https://myapp.com/pingonesdk?authentication_code=7F45HGF5", "pingonesdk?authentication_code=7F45HGF5"

```swift
/// Authenticate with code
///
/// PingOne SDK provides an ability to authenticate via scanning the QR code.
/// The retrieved value should be passed to the PingOne SDK using the following API method.
///
/// - Parameters:
///   - authCode: String value of the authentication code, parsed from QR or manual input.
/// - Returns: a completionHandler that contains `authenticationObject`: users list array, clientContext object,
/// userApproval String and status String. In case of an error will return NSError.
@objc public static func authenticate(_ authCode: String, completionHandler: @escaping (_ authenticationObject: AuthenticationObject?, _ error: NSError?) -> Void) 
```
AuthenticationObject return from the authenticate method, contains the following varibles and methods:

```swift   
/// List of users that are paired to this device. Each user object can contain the following String variables: `userId`, `email`, `given`, `family` and `username`.
@objc public var users: [[String: Any]]?
/// String that determines if user approval is required to complete an authentication. Possible values: `REQUIRED` and `NOT_REQUIRED`
@objc public var userApproval: String?
/// Object for passing any data as a String from server to end-user
@objc public var clientContext: String?
/// String value returned from a server when a user calls an authenticate API method. Possible values: can be `CLAIMED`, `EXPIRED`, `DENIED` or `COMPLETED`
@objc public var status: String?
    
/// Approve authentication with code
///
/// If `userApproval` is `REQUIRED` or multiple users may approve the authentication,
/// call this method with a userId of the user, who triggered the method.
/// - Parameter userId: String value of the user id, fetched from the user object.
/// - Returns completionHandler: Will return status String value with one of the following values:
/// `COMPLETED` or `EXPIRED`.
/// Returns NSError in case of an error.
@objc public final func approve(userId: String, completionHandler: @escaping (_ status: String?, _ error: NSError?) -> Void) 

/// Deny authentication with code
///
/// If `userApproval` is `REQUIRED` or multiple users may deny the authentication,
/// call this method with a userId of the user, who triggered the method.
/// - Parameter userId: String value of the user id, fetched from the user object.
/// This field is not mandatory, authentication can be denied without passing this value.
/// - Returns completionHandler: Will return status String value with one of the following values:
/// `DENIED` or `EXPIRED`.
/// Returns NSError in case of an error.
@objc public final func deny(_ userId: String? = nil, completionHandler: @escaping (_ status: String?, _ error: NSError?) -> Void)
```

<a name="auth_framework"></a>
## 3. Mobile Authentication Framework

The following method starts an authentication process when the user taps "Authentication API" on the main screen. The authentication process is completed by the PingFederate Authentication API.
**Note:** Before running this method, you need to update your `oidcIssuer` and `clientId` in the Config.swift class. See [Authentication API for Developers Mobile iOS code](https://github.com/pingidentity/mobile-authentication-framework-ios)

```swift
func authenticate(With payload: String){
    authnUI.authenticate(presenter: self, payload: payload, dynamicData: "") { [weak self] (serverPayload, accessToken, error) in
        guard let self = self else { return }
        
        if (serverPayload.count > 0) { //Need pairing
           PingOne.processIdToken(serverPayload) { (pairingObject, error) in
               self.stopLoadingAnimation()
               if let pairingObject = pairingObject{
                   self.displayNotificationViewAlert(pairingObject)
               }
               else if let error = error{
                   print(error.localizedDescription)
               }
           }
        } else {
           self.stopLoadingAnimation()
        }
    }
}
```

<a name="migrate"></a>
## 4. Migrate from PingID SDK to PingOne SDK
If your app is currently integrated with the PingID SDK, it is possible to migrate to PingOne SDK.
First, make sure to set up the PingOne environment in the admin console following convergence documentation. Next, set up your mobile app as follows:
1. Remove the `PingID_SDK.xcframework` framework from your project and any methods that call this SDK.
2. Add and set up the `PingOne` framework as described in the [Set up](#setup) section and implement SDK methods as described in [PingOne Mobile SDK sample app](#sample_app) sections above.
3. Add the `migrateFromPingID` method at the desired place in your app. For example, it can be called from the `didFinishLaunchingWithOptions` method.
 
Notes:
1. In order to check if the device is paired, call the `getInfo` method in `PingOne`. For paired devices, the `getInfo` response including users array will be returned successfully with no error.
2. In case the `setKeepTrustedDeviceAfterReinstall` method was set to `true` in `PingID` SDK, upon app reinstall the device will be able to migrate to `PingOne` SDK.
 
**Important:** PingOne and PingID SDKs can not coexist together in the same Xcode project, make sure to remove any code that calls `PingID` in the migrated mobile app.
 
<a name="migrate_manual"></a>
### 4.1 Manual flow
Call the `migrateFromPingID` method as follows:
```swift
/// Migrate from PingID
///
/// Migrates the PingID SDK application to the PingOne platform
///
/// - Returns: a `completionHandler` which contains: `status` - integer that reflects the migration status,
/// `PairingInfo` - an array of the permitted authentication methods - see description of pair method
/// and `error` in case of an error will return NSError.
@objc public static func migrateFromPingID(completionHandler: @escaping (_ status: MigrationStatus, _ response: PairingInfo?, _ error: NSError?) -> Void)
```
 
The `MigrationStatus` returned from `migrateFromPingID` is an enum with several possible statuses that represents the migration current status.
```swift
/// Enum that represents the migration status returned from the SDK
@objc public enum MigrationStatus: NSInteger {
   /// There is no PingID data that has to be migrated.
   case notNeeded               = 10000
   /// Migration completed.
   case done                    = 10001
   /// Migration failed.
   case failed                  = 10002
   /// Migration failed due to server error, client can try again.
   case temporaryFailed         = 10003
   /// Migration in progress.
   case inProgress              = 10004
}
```
 
**Note:** The `temporaryFailed`status is recoverable, developer can try calling the `migrateFromPingID` again. This can happen due to temporary errors such as connectivity issues or timeout.
 
Possible errors returned from the `migrateFromPingID` as follows:
```swift
/// Migration is currently in progress - you cannot make another API call until it is completed.
   case migrationAlreadyRunning            = 10014
/// The device does not need to be migrated because it is already paired.
   case migrationNotNeeded                 = 10015
```
<a name="migrate_push"></a>
### 4.2 Push notification flow
Upon getting authentication push notification, the migration will start when the user interacts with the push notification. In this case, migration starts ***automatically*** in a background thread. When migration is completed, the PingOne Notification object will return to the app in the `PingOne.processRemoteNotification` response.
 
**Note:** The PingOne notification object that returns in the migration process holds different `title` and `body` localization keys than in PingID SDK, due to APNS limitation. In order to handle migration push localization, need to implement parsing method as shown below:
 
```swift
func getNotificationTextFrom(_ userInfo: [String: Any]) -> (title: String, body: String) {
     if let aps = userInfo[Push.aps] as? [String: Any] {
         if let alert = aps[Push.alert] as? [String: String] {
             if let title = alert[Push.title], let body = alert[Push.body] {
                  return (title, body)
             }
             // For first push after migration only
             if let MigrationTitle = alert[Push.MigrationTitle], let MigrationBody = alert[Push.MigrationBody] {
                  return (MigrationTitle, MigrationBody)
             }
         }
     }
     return ("", "")
 }
}
```
 
The constants above are stored in this struct:
```swift
struct Push {
 static let aps                     = "aps"
 static let alert                   = "alert"
 static let title                   = "title-loc-key"
 static let body                    = "loc-key"
 static let MigrationTitle          = "title"
 static let MigrationBody           = "body"
}
```
 

## Disclaimer

THE SAMPLE CODE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SAMPLE CODE OR THE USE OR OTHER DEALINGS IN
THE SAMPLE CODE.  FURTHERMORE, THIS SAMPLE CODE IS NOT COMMERCIALLY SUPPORTED BY PING IDENTITY BUT QUESTIONS MAY BE ADDRESSED TO PING'S SUPPORT CENTER OR MAY BE OTHERWISE ADDRESSED IN THE RELATED DOCUMENTATION.

Any questions or issues should go to the support center, or may be discussed in the [Ping Identity developer communities](https://community.pingidentity.com/collaborate).
