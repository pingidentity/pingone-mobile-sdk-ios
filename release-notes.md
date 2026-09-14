# Release Notes

## v2.4.1 - August 2nd, 2026
- Fixed an issue where the device's private key type could be misreported as EC instead of RSA.

## v2.4.0 - July 27th, 2026
Features:

- Added async/await support across the PingOne public API, alongside the existing completion-handler methods.
- Integrated Apple App Attest to strengthen device integrity verification.
- Improved reliability and thread safety across configuration, logging, key rotation, and device posture analysis.

Compatibility:

- Updated minimum OS target to iOS 16.0.

Dependencies:

- Removed the Reachability dependency; network reachability is now handled using native Apple APIs.

## v2.3.2 - Jul 6th, 2026
- Fixed a race condition where the SDK could cache the default private key type instead of updating it with the actual key type after key creation.
- Fixed a race condition that could cause the trust operation to run multiple times.

## v2.3.1 - May 17th, 2026
- Improved detection of jailbroken devices.

## v2.3.0 - April 26th, 2026
- Fixed an issue where the push notification auth timeout defaulted to the maximum value rather than the calculated one.
- Updated the getOneTimePasscode() method to return an explicit error when One-Time Passcode (OTP) is not enabled.
- NotificationObject.approve() now returns a `confirmationInfo` object to support future capabilities, as well as specific error codes for device-related approval failures.
- Added the `DenyReason enum` to specify the reason for a denial for `NotificationObject.deny()`.

Deprecations:

- Deprecated `deny(completionHandler: @escaping (_ error: NSError?)` Use `deny(reason: DenyReason = .none, completionHandler: @escaping (_ error: NSError?) -> Void)`

## v2.2.1 - March 1st, 2026
- Fixed an issue where the keychain entry remained after configuration and reinstallation instead of being properly deleted.
- Resolved a bug that caused the SDK to lose trust with the server when keychain errors occurred.

## v2.2.0 - December 11th, 2025
- Resolved an issue where the configuration callback was being invoked multiple times
- Fixed a defect that prevented the `getInfo()` method from being executed following an application restart or during background-to-foreground transitions under certain conditions.
- Corrected a failure scenario that caused QR Code Authentication to malfunction
- Addressed an issue where the One-Time Passcode (OTP) refresh duration did not update based on the configured refresh duration, remaining fixed at 30 seconds

## v2.1.1 - July 6th, 2025
- Fixed an issue that was causing pairing of devices to fail in PingOne's Australia and Canada regions.

## v2.1.0 - June 22nd, 2025
Features:

- Added support for the PingOne Singapore geography
- Deprecated the setDevicePairedAfterReinstall method, as it is scheduled for removal in a future release 
- Added new package dependencies for the following libraries:  
  **JOSESwift**, **Reachability**, **SwiftOTP**, and **ZIPFoundation**
- Fixed a bug where `PingOne.pair()` triggered the `completionHandler` twice  
  [Issue #48](https://github.com/pingidentity/pingone-mobile-sdk-ios/issues/48)

## v2.0.0 - April 1st, 2025
Features:

- The PingOne MFA SDK has been updated to allow the same device to be paired with users in different geographic regions.
- The SDK now has a method called `testRemoteNotification` that allows you to test and debug push notification functionality.
- A new mandatory method called `PingOne.configure()` has been added. This method is used to set up the SDK.
- The following methods have been deprecated: `getInfo` and `generateMobilePayload`.
- The method `setDeviceToken` was updated to return array of errors.
- Cancel Authentication feature added: lets PingOne server send a new notification with `authCanceled` notification type, to the user’s device if they switch to a different device during the authentication process. This notification type tells the app that the authentication was canceled, so the app can remove any pop-up without waiting for a timeout, ensuring a smoother user experience.
- Number Matching feature added: This is an enhanced authentication method where a number is displayed on the web interface, and the user must input the same number on their mobile device after receiving a push notification, with parameter `numberPicked`, in the `NotificationObject.approve()` method. This ensures the user controls both devices, adding an extra layer of security to prevent accidental or unauthorized approvals.

Compatibility:

- Updated minimum OS target to iOS 15.0.

## v1.10.1 - May 12th, 2024
Features:

- In situations where multiple users carried out OIDC-based pairing on the same device without the application being closed in between, error 10013 was displayed - "Pairing is currently in progress - you cannot make another API call until it is completed." 
This issue has been resolved.

## v1.10.0 - Jun 26th, 2023
Features:

- The PingOne MFA SDK has been updated to rotate encryption keys once a year. Key rotation events are written to the audit log.

## v1.9.0 - April 2nd, 2023
Features:

- Updated SDK to version 1.9.0.
- Bug fixes and performance improvement.
