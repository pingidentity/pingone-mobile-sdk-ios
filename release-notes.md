# Release Notes

## v1.7.2 - Aug 31st, 2022
Features:
 
- Updated SDK to version 1.7.2.
- Added support for alphanumeric pairing key.
- Bug fixes and performance improvement.

## v1.7.1 - June 1st, 2022
Features:
 
- Updated SDK to version 1.7.1.

## v1.7.0 - April 25th, 2022
Features:
 
- Updated SDK to version 1.7.0.
- Updated the SDK import name.
    If you are upgrading from 1.6.0 or lower:
    - Go to each class that uses the SDK.
    - Change in the import area "import PingOne" into "import PingOneSDK".
- Added support for authentication using QR Code scanning or manual typing an authentication code.
- Started supporting secured signing with Elliptic Curve algorithm, using the iOS secure enclave component (on devices using Apple A7 or later A-series processors).
 
Compatibility notes:
 
- Supports Xcode 13 and above.
- Increased minimum iOS supported version to iOS 12.
- SDK will use Elliptic Curve signature for fresh users only, not for users who upgrade from 1.6.0.

## v1.6.0 - August 1st, 2021
Features:

- Sample app was updated to work with the latest SDK version 1.6.0.
- Supports device integrity checks for rooted and jailbroken devices.

## v1.5.0 - April 6th, 2021
Features:

- Updated the SDK version 1.4.0.
- Added support for one time passcode and disable SDK push notifications.

Compatibility notes:

- Deprecated current pairing method and added support to new one with returned object of PairingInfo. 
- Supports Xcode 12 and above.

## v1.4.0 - Jan 5th, 2021
Features:

- Added support for Mobile Authentication Framework for iOS Developers. See the `AuthnAPI` folder.

## v1.3.0 - June 18th, 2020
Features:

- Push notification data is now JWT-signed and verified
- Added `clientContext` to the push notification object. `clientContext` contains extra parameters that are passed to the client.
- Added support for background push notification (extra verification) during device authorization

Known issues:

- If the iOS device clock is set to manual update instead of automatic, the automatic pairing process could fail.

## v1.2.0 - March 31st, 2020
Features:

- Support for sending logs (both by app and admin)
- Ability to track authentication expiration time in the app

## v1.1.0 - December 9th, 2019
Features:

- Support for automatic pairing via OpenID Connect authentication.
- The `pair()` function now returns error code 10007 `pairingKeyDataCenterMismatch`, when trying to pair a user in a different geographical datacenter than the users already paired on the device.

Compatibility notes:

- Deprecated functions: `NotificationObject.approve(completionHandler: @escaping (NSError?) -> Void)`
	  `@objc public static func processRemoteNotificationAction(_ identifier: String, forRemoteNotification userInfo: [AnyHashable : Any], completionHandler: @escaping (PingOne.NotificationObject?, NSError?) -> Void)`
- Sample app now using AppAuth 1.3.0

## v1.0.2 - October 30th, 2019
Features:
- Support for APAC datacenter.

Compatibility notes:
- support Swift 5.1.


## v1.0 - August 1st, 2019
Features:
- Provide MFA capability (using push notifications) for iOS native apps.
