# PingOne MFA Mobile SDK

## Overview

PingOne MFA Mobile SDK is a set of components and services targeted at enabling organizations to include multifactor authentication (MFA) into native applications.
This solution leverages Ping Identity’s expertise in MFA technology, as a component that can be embedded easily and quickly into a new or existing application. 

Release notes can be found [here](./release-notes.md).

### Documentation

Reference documentation is available for PingOne MFA Mobile SDK, describing its capabilities, features, installation and setup, integration with mobile apps, deployment and more: 

* [Introduction to PingOne MFA](https://docs.pingidentity.com/csh?Product=p1&context=p1mfa_c_introduction)
* [PingOne MFA Mobile SDK Overview](https://apidocs.pingidentity.com/pingone/native-sdks/v1/api/#pingone-mfa-sdk-for-ios)
* [PingOne MFA Mobile SDK API Documentation](https://pingidentity.github.io/pingone-mobile-sdk-ios)
* [PingOne MFA Mobile SDK Sample App](https://github.com/pingidentity/pingone-sample-app-ios)
* [PingOne MFA SDK Ready-For-Use Authenticator App](https://github.com/pingidentity/pingone-authenticator-sample-app-ios)

### Content

1. [Prerequisites](#prerequisites)
2. [Configure iOS push messaging on the PingOne Portal](#configure_push)
3. [Compatibility](#compatibility)
4. [Installation](#installation)
    1. [Installing with the Swift Package Manager](#installation_package)
    2. [Manual downloading from the Ping Identity Assets](#installation_manual)
5. [Working with push messages in iOS](#work_with_push)
6. [Register device token on PingOne server](#register_device)
7. [Handling Push Notifications](#handle_push)
8. [Localization](#localization)
9. [Kechain Sharing](#kechain_sharing)


<a name="prerequisites"></a>
#### 1. Prerequisites

Prepare the iOS push messaging mandatory data from Apple Developer portal:

* Key ID
* Team ID
* Token .p8 file
* Bundle ID

Refer to: [Establishing a Token-Based Connection to APNs](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/establishing_a_token-based_connection_to_apns).

<a name="configure_push"></a>
#### 2. Configure iOS push messaging on the PingOne Portal

When configuring your PingOne SDK application in the PingOne admin web console (**Connections > Applications > {NATIVE application} > Edit > Authenticator**), you should upload your .p8 token and fill in the Key ID, Team ID and Bundle ID. See [Edit an application](https://docs.pingidentity.com/bundle/pingone/page/jez1625773795534.html) in the administration guide.

Beginning with iOS 15, users can define focus modes. In a defined focus mode, all notifications are blocked except those from apps that you choose to allow or notifications that are defined as "time-sensitive".

If you want notifications from the app that you are developing with the PingOne Mobile SDK to be defined as "time-sensitive", follow these steps:

* In the Xcode project, select your target -> tap the `Signing & Capabilities` tab -> add the `Time Sensitive Notifications` capability.
* Make sure to update your app Identifier in the Apple developer account to support `Time Sensitive Notifications`.
* After the identifier is updated, you need to update the app provision profiles as well. 

For more information, see the Apple documentation on [managing identifiers](https://developer.apple.com/help/account/manage-identifiers/enable-app-capabilities) and [adding capabilities to your app](https://developer.apple.com/documentation/xcode/adding-capabilities-to-your-app).

<a name="compatibility"></a>
#### 3. Compatibility

**Note:** PingOne SDK supports the following software versions:

* Xcode 14 and above.
* iOS 12.0 and above.

<a name="installation"></a>
#### 4. Installation

You can use either of the following methods to add the PingOne SDK component to your existing project:

* Install with the Swift Package Manager
* Install from the Ping Identity Assets

<a name="installation_package"></a>
##### 4.1 Installing with the Swift Package Manager

1. Select File → Add Packages… in Xcode’s menu bar.
2. Search for the PingOne SDK using the repo's URL: `https://github.com/pingidentity/pingone-mobile-sdk-ios.git`
3. Set the Dependency Rule to `Branch` with value `main`, and make sure that `Add to Project` is set to your project.
4. Select Add Package.
5. Verify that the package was downloaded in your project.

<a name="installation_manual"></a>
##### 4.2 Manual downloading from the Ping Identity Assets

1. Download the latest version [1.10.0](https://assets.pingone.com/pingonemobile/ios-sdk/release/PingOneSDK.xcframework.1.10.0.zip).
2. Unzip the PingOneSDK.xcframework zipped file and drag it into your project.
3. In your **Project Navigator**, click on your target, and drag **PingOneSDK.xcframework** to **Frameworks, Libraries, and Embedded Content**.
4. Check the **Copy items if needed** checkbox.

    ![](./img/p1_i_xc11-SDKintegrateIntoIDE.png)

5. Integrate the PingOneSDK component into your code:
	* Import the framework into your application initialization code:<br>`import PingOneSDK`

<a name="work_with_push"></a>
#### 5. Working with push messages in iOS

This section details the steps needed in order to work with push messages in iOS:

* Enable **Push Notifications**: Go to your Project Navigator’s **capabilities** tab. Select **Push Notifications > Enable**.
* Enable **Remote Notifications**: Go to your Project Navigator’s **capabilities** tab. Turn on **Background Modes > Remote notifications**.
* Enable **Push Notifications** in your **Apple Developer Account > Certificates, Identifiers & Profiles > Identifiers > Capabilities > Push Notifications > Enable**.
* Enter your app’s **Deployment Details** settings in your **Apple Developer Account > Certificates, Identifiers & Profiles > Identifiers > Your App ID.** These details are now mandatory prerequisites for Apple to register your device for push notifications.

<a name="register_device"></a>
#### 6. Register device token on PingOne server

In order to receive push notifications from PingOne SDK, use the following code in your `didRegisterForRemoteNotificationsWithDeviceToken` call, passing the deviceToken as is:

```swift
@objc public static func setDeviceToken(_ deviceToken: Data, type: APNSDeviceTokenType, completionHandler: @escaping (_ error: NSError?) -> Void)
```

<a name="handle_push"></a>
#### 7. Handling Push Notifications

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

<a name="localization"></a>
#### 8. Localization

The following keys are returned by the PingOne SDK Remote Notification, with suggested localization:

```swift
"notification.confirm"  = "Approve";
"notification.deny"     = "Deny";
"notification.message"  = "You have a new authentication request.";
"notification.title"    = "New Authentication";
```

**Note:** An example of these keys is provided in the sample app, in the `Localizable.strings` file.

<a name="kechain_sharing"></a>
#### 9. Keychain Sharing

**Note:** This step is required only if your app uses Keychain Sharing.
Make sure that the first item on your Keychain Groups is `YOUR_BUNDLE_ID` (your private keychain group). This requirement will ensure that the SDK keychain values are private, and are not shared between apps​:

![](./img/p1_i_SDKkeychainSharing.png)

## Disclaimer

THE SAMPLE CODE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SAMPLE CODE OR THE USE OR OTHER DEALINGS IN
THE SAMPLE CODE.  FURTHERMORE, THIS SAMPLE CODE IS NOT COMMERCIALLY SUPPORTED BY PING IDENTITY BUT QUESTIONS MAY BE ADDRESSED TO PING'S SUPPORT CENTER OR MAY BE OTHERWISE ADDRESSED IN THE RELATED DOCUMENTATION.

Any questions or issues should go to the support center, or may be discussed in the [Ping Identity developer communities](https://community.pingidentity.com/collaborate).
