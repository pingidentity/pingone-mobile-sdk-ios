# Release Notes

## v2.1.0 - June 17th, 2025
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
