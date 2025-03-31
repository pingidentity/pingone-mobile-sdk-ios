# PingOne MFA Mobile SDK

## Overview

PingOne MFA Mobile SDK is a set of components and services targeted at enabling organizations to include multifactor authentication (MFA) into native applications.
This solution leverages Ping Identity’s expertise in MFA technology, as a component that can be embedded easily and quickly into a new or existing application. 

Release notes can be found [here](./release-notes.md).

### Documentation

Reference documentation is available for PingOne MFA Mobile SDK, describing its capabilities, features, installation and setup, integration with mobile apps, deployment and more: 

* [Introduction to PingOne MFA](https://docs.pingidentity.com/csh?Product=p1&context=p1mfa_c_introduction)
* [PingOne MFA Mobile SDK Overview](https://apidocs.pingidentity.com/pingone/native-sdks/v1/api/#pingone-mfa-sdk-for-ios)
* [PingOne MFA Mobile SDK API Documentation](https://pingidentity.github.io/pingone-mobile-sdk-ios/documentation/pingonesdk)
* [PingOne MFA Mobile SDK Sample App](https://github.com/pingidentity/pingone-sample-app-ios)
* [PingOne MFA SDK Ready-For-Use Authenticator App](https://github.com/pingidentity/pingone-authenticator-sample-app-ios)

### Content

1. [Prerequisites for using Apple Push Notifications Service](#prerequisites)
2. [Configure the SDK](#configure)
3. [Set up iOS push messaging in the PingOne admin console](#set_up_push)
4. [Compatibility](#compatibility)
5. [Installation](#installation)
    1. [Installing with the Swift Package Manager](#installation_package)
    2. [Manual download from the Ping Identity Assets](#installation_manual)
6. [Register device token on PingOne server](#register_device)
7. [Handling Push Notifications](#handle_push)
8. [Working with push messages in iOS](#work_with_push)
9. [Test Push Notifications](#test_push)
10. [Localization](#localization)
11. [Kechain sharing](#kechain_sharing)


<a name="prerequisites"></a>
#### 1. Prerequisites for using Apple Push Notifications Service

Prepare the iOS push messaging mandatory data from Apple Developer portal:

* Key ID
* Team ID
* Token .p8 file
* Bundle ID

See [Establishing a Token-Based Connection to APNs](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/establishing_a_token-based_connection_to_apns).

<a name="configure"></a>
#### 2. Configure the SDK

You must configure the SDK at least once before using it. Configure the SDK using `PingOne.configure()`, which sets the PingOne geography that the SDK will use as the "trust issuer". Note that you only specify one geography for the `configure` method, but this makes it possible to pair the device in multiple geographies (NA, EU etc).

```swift
/// Initializes the PingOne SDK for a specific geo.
    ///
    /// - Parameter geo: The selected enum value.
    /// Possible values are: `NorthAmerica`, `Europe`, `Canada` and `Australia`.
    ///
    /// > Warning: If this method is not called, the SDK will throw an error.
    ///
    /// - Returns: NSError in case of an error.
    @objc public static func configure(geo: PingOneGeo, completionHandler: @escaping (_ error: NSError?) -> Void)
```

Select the desired geo from the PingOneGeo enum:

```swift
/// Public enum that describes the geographical servers available for PingOne SDK.
@objc public enum PingOneGeo: NSInteger, Codable {
    /// North America
    case NorthAmerica
    /// Europe
    case Europe
    /// Australia
    case Australia
    /// Canada
    case Canada
}
```

##### Warning

Once the device is configured for a specific geography, `configure(PingOneGeo)` cannot be used to select a new geography. If you must change the geography for purposes such as testing, 
you must reset the device by calling `removePingOneLocalData()`, which also clears all SDK memory in the mobile cache.

PingOne server supports multi-region, therefore any geography can be used as the trust issuer, not necessarily the one the device is paired to.


<a name="set_up_push"></a>
#### 3. Set up iOS push messaging in the PingOne admin console

To define your PingOne SDK-based application in the PingOne admin console (**Applications > Applications > {NATIVE application} > Edit > Mobile**), you will need to upload your .p8 token and provide the Key ID, Team ID, and Bundle ID. See [Editing an application](https://docs.pingidentity.com/pingone/applications/p1_edit_application_native.html) - Native in the PingOne administration guide.

Beginning with iOS 15, users can define focus modes. In a defined focus mode, all notifications are blocked except those from apps that you choose to allow or notifications that are defined as "time-sensitive".

If you want notifications from the app that you are developing with the PingOne Mobile SDK to be defined as "time-sensitive", follow these steps:

* In the Xcode project, select your target -> tap the `Signing & Capabilities` tab -> add the `Time Sensitive Notifications` capability.
* Make sure to update your app Identifier in the Apple developer account to support `Time Sensitive Notifications`.
* After the identifier is updated, you need to update the app provision profiles as well. 

For more information, see the Apple documentation on [managing identifiers](https://developer.apple.com/help/account/manage-identifiers/enable-app-capabilities) and [adding capabilities to your app](https://developer.apple.com/documentation/xcode/adding-capabilities-to-your-app).

<a name="compatibility"></a>
#### 4. Compatibility

**Note:** PingOne SDK supports the following software versions:

* Xcode 14 and above.
* iOS 15.0 and above.

<a name="installation"></a>
#### 5. Installation

You can use either of the following methods to add the PingOne SDK component to your existing project:

* Install with the Swift Package Manager
* Install from the Ping Identity Assets

<a name="installation_package"></a>
##### 5.1 Installing with the Swift Package Manager

1. Select File → Add Packages… in Xcode’s menu bar.
2. Search for the PingOne SDK using the repo's URL: `https://github.com/pingidentity/pingone-mobile-sdk-ios.git`
3. Set the Dependency Rule to `Branch` with value `main`, and make sure that `Add to Project` is set to your project.
4. Select Add Package.
5. Verify that the package was downloaded in your project.

<a name="installation_manual"></a>
##### 5.2 Manual download from the Ping Identity Assets

1. Download the latest version [2.0.0](https://assets.pingone.com/pingonemobile/ios-sdk/release/PingOneSDK.xcframework.2.0.0.zip).
2. Unzip the PingOneSDK.xcframework zipped file and drag it into your project.
3. In your **Project Navigator**, click on your target, and drag **PingOneSDK.xcframework** to **Frameworks, Libraries, and Embedded Content**.
4. Check the **Copy items if needed** checkbox.

    ![](./img/p1_i_xc11-SDKintegrateIntoIDE.png)

5. Integrate the PingOneSDK component into your code:
	* Import the framework into your application initialization code:<br>`import PingOneSDK`

<a name="register_device"></a>
#### 6. Register device token on PingOne server

In order to receive push notifications from PingOne SDK, use the following code in your `didRegisterForRemoteNotificationsWithDeviceToken` call, passing the deviceToken as is:

```swift
@objc public static func setDeviceToken(token deviceToken: Data, type: APNSDeviceTokenType, completionHandler: @escaping (_ error: [NSError]?) -> Void)
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

<a name="work_with_push"></a>
#### 8. Working with push messages in iOS

This section details the steps needed in order to work with push messages in iOS:

* Enable **Push Notifications**: Go to your Project Navigator’s **capabilities** tab. Select **Push Notifications > Enable**.
* Enable **Remote Notifications**: Go to your Project Navigator’s **capabilities** tab. Turn on **Background Modes > Remote notifications**.
* Enable **Push Notifications** in your **Apple Developer Account > Certificates, Identifiers & Profiles > Identifiers > Capabilities > Push Notifications > Enable**.
* Enter your app’s **Deployment Details** settings in your **Apple Developer Account > Certificates, Identifiers & Profiles > Identifiers > Your App ID.** These details are now mandatory prerequisites for Apple to register your device for push notifications.

##### Push Notification Setup

When the app starts, `UIApplication.shared.registerForRemoteNotifications()` is called to retrieve an APNS push token from the OS. After obtaining the token, it must be set in the PingOne SDK using `setDeviceToken()` before pairing, as this step stores the token locally for push notification authentication.

If pairing is done before calling `setDeviceToken()`, you can still update the token on the server by calling `setDeviceToken()` afterward, which will enable push notifications.

##### Controlling Push Notifications

1. **`setDeviceToken()`** — Must be called at least once with a valid token to enable push notifications.
2. **`allowPushNotifications()`** — Optional, used to disable push notifications.

- If `setDeviceToken()` is called and is not `allowPushNotifications(false)`, then `device.pushEnabled` in PingOne server is set to `true`.
- If `allowPushNotifications(false)` is called or `setDeviceToken()` is not called, `device.pushEnabled` is set to `false`.

The only way to toggle `device.pushEnabled` is by calling `setDeviceToken()` or `allowPushNotifications()`.

##### Push Notification Configuration Results

The table below outlines the results of different configurations for push notifications based on the app's notification settings and background refresh settings:

| Notification Setting for App | Background Refresh for App | Push will be sent during auth | "PUSH ENABLED" |
|------------------------------|----------------------------|-------------------------------|----------------|
| **TRUE**                     | TRUE                       | TRUE                          | TRUE           |
| **FALSE**                    | TRUE                       | TRUE                          | TRUE           |
| **TRUE**                     | FALSE                      | TRUE                          | TRUE           |
| **FALSE**                    | FALSE                      | FALSE                         | TRUE           |

###### Explanation:

- **Notification Setting for App**: Indicates whether notifications are enabled for the app.
- **Background Refresh for App**: Indicates whether background refresh is enabled, allowing the app to update content in the background.
- **Push will be sent during auth**: Shows whether a push notification will be sent during authentication based on the combination of notification and background refresh settings.
- **"PUSH ENABLED"**: Indicates whether push notifications are globally enabled for the app.

###### Points to note:

- Push notifications during authentication (`Push will be sent during auth`) are dependent on both the notification setting and the background refresh setting.
  - If either setting is `TRUE`, push notifications can still be sent during authentication except when both settings are `FALSE`.
- The `"PUSH ENABLED"` status remains `TRUE` regardless of individual settings, indicating that the capability to receive pushes is not directly tied to these specific settings but may depend on broader system configurations or other conditions.


<a name="test_push"></a>
#### 9. Test Push Notifications

For paired devices, it is possible to test push notification functionality using the `testRemoteNotification` method:

```swift
/// Run push notification test
///
/// This method tests the push notification flow for a specified paired geo.
///
/// - Parameter geo: The selected geo, represented by an enum value.
/// Valid options include: `NorthAmerica`, `Europe`, `Canada`, and `Australia`.
///
/// - Returns: An array of `NotificationTest` objects. In case of an error, an `NSError` object is returned.
@objc public static func testRemoteNotification(_ geo: PingOneGeo, completionHandler: @escaping (_ results: [NotificationTest]?, _ status: NotificationTest.TestResult, _ error: NSError?) -> Void)
```

This method returns a status from the `TestResult` enum, summarizing the test result:

```swift
/// Test passed successfully.
case pass
/// Test failed, push notification will not show.
case fail
/// Test failed but possibly push notification will show with some limitation.
case warning
```

The SDK runs the following tests, which are returned in the results array as NotificationTest objects with different test types:
For each `NotificationTest`, developers can access the following information to understand the test content and results:

```swift    
/// Public enum that describes the notification of all tests name, description, and results Info.
@objc public enum TestType: NSInteger {
    case tokenType
    case allowNotification
    case token
    case notificationsSetting
    case backgroundSetting
    case connectivity
    case categories
    case testPush
    case setPushPayloadToSDK
}

/// The name of the test.
@objc public var name
/// The description of the test.
@objc public var testDescription
/// The test result represented by `TestResult`.
@objc public var testResult
/// In case the test didn't pass, information that explains the failure reason and how to overcome it.
@objc public var resultsInfo
```

See the PingOne MFA Mobile SDK Sample App [repository](https://github.com/pingidentity/pingone-sample-app-ios) for sample code on how to utilize the testRemoteNotification method for debugging push notifications.

<a name="localization"></a>
#### 10. Localization

The following keys are returned by the PingOne SDK Remote Notification, with suggested localization:

```swift
"notification.confirm"  = "Approve";
"notification.deny"     = "Deny";
"notification.message"  = "You have a new authentication request.";
"notification.title"    = "New Authentication";
```

**Note:** An example of these keys is provided in the sample app, in the `Localizable.strings` file.

<a name="kechain_sharing"></a>
#### 11. Keychain sharing

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

Any questions or issues should go to the support center, or may be discussed in the [Ping Identity developer communities](https://support.pingidentity.com/s/topic/0TO1W000000atTxWAI/pingone-mfa).
