//
//  AppDelegate.swift
//  SampleApp
//
//  Created by Ping Identity on 3/12/19.
//  Copyright © 2019 Ping Identity. All rights reserved.
//

import UIKit
import UserNotifications
import PingOneSDK
import AppAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    var currentAuthorizationFlow: OIDExternalUserAgentSession?
    var notificationObject: NotificationObject?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            window!.overrideUserInterfaceStyle = .light
        }
        self.registerRemoteNotifications()

        return true
    }
    
    func registerRemoteNotifications() {
        print("Registering remote notifications")
        
        let center  = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
            if error == nil {
                // Registering UNNotificationCategories more than once results in previous categories being overwritten. PingOne provides the needed categories. The developer may add categories.
                UNUserNotificationCenter.current().setNotificationCategories(PingOne.getUNNotificationCategories())
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let deviceTokenString = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("Device Token: \(deviceTokenString)")

        var deviceTokenType: PingOne.APNSDeviceTokenType = .production
        #if DEBUG
        deviceTokenType = .sandbox
        #endif
        
        PingOne.setDeviceToken(deviceToken, type: deviceTokenType) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("didReceive")
        
        PingOne.processRemoteNotificationAction(response.actionIdentifier, authenticationMethod: "user", forRemoteNotification: response.notification.request.content.userInfo) { (notificationObject, error) in
            
            if let error = error {
                print("Error: \(String(describing: error))")
                if error.code == ErrorCode.unrecognizedRemoteNotification.rawValue {
                    // Do something else with remote notification.
                }
            } else if let notificationObject = notificationObject { // User pressed the actual banner, instead of an action.
               if let userInfo = response.notification.request.content.userInfo as? [String: Any] {
                   let title = self.getNotificationTextFrom(userInfo).title
                   let message = self.getNotificationTextFrom(userInfo).body
                   self.displayNotificationViewAlert(notificationObject, title: title, msg: message)
               }
            }
            DispatchQueue.main.async {
                completionHandler()
            }
        }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("didReceiveRemoteNotification userinfo: \(userInfo)")
        
        PingOne.processRemoteNotification(userInfo) { (notificationObject, error) in
            if let error = error {
                print("Error: \(String(describing: error))")
                if error.code == ErrorCode.unrecognizedRemoteNotification.rawValue {
                    // Unrecognized remote notification.
                    completionHandler(UIBackgroundFetchResult.noData)
                }
            } else if let notificationObject = notificationObject {
                self.notificationObject = notificationObject
                switch notificationObject.notificationType {
                case .authentication:
                    
                    if let userInfo = userInfo as? [String: Any] {
                        let title = self.getNotificationTextFrom(userInfo).title
                        let message = self.getNotificationTextFrom(userInfo).body
                        self.displayNotificationViewAlert(notificationObject, title: title, msg: message)
                        completionHandler(UIBackgroundFetchResult.newData)
                    }

                default:
                    print("Error: \(String(describing: error))")
                    completionHandler(UIBackgroundFetchResult.noData)
                }
            } else {
                completionHandler(UIBackgroundFetchResult.noData)
            }
        }
    }
    
    func getNotificationTextFrom(_ userInfo: [String: Any]) -> (title: String, body: String) {
        
        if let aps = userInfo[Push.aps] as? [String: Any] {
            if let alert = aps[Push.alert] as? [String: String] {
                if let title = alert[Push.title], let body = alert[Push.body] {
                     return (title, body)
                }
            }
        }
        return ("", "")
    }
    
    func displayNotificationViewAlert(_ notificationObject: NotificationObject, title: String, msg: String) {
        DispatchQueue.main.async {
            
            var displayOnVc: UIViewController
            guard let rootVc = self.window?.rootViewController else {
                return
            }
            
            if rootVc.presentedViewController != nil {
                displayOnVc = rootVc.presentedViewController!
            } else {
                displayOnVc = rootVc
            }

            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationRecived"), object: nil)

            Alert.approveDeny(viewController: displayOnVc, title: title, message: msg) { (approved) in
                if let approved = approved {
                    if approved {
                        notificationObject.approve(withAuthenticationMethod: "user", completionHandler: { (error) in
                            if error != nil {
                                Alert.generic(viewController: displayOnVc, message: msg, error: error)
                            }
                        })
                    } else {
                        notificationObject.deny(completionHandler: { (error) in
                            if error != nil {
                                Alert.generic(viewController: displayOnVc, message: msg, error: error)
                            }
                        })
                    }
                }
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationResponded"), object: nil)
            }
        }
    }
    
    // OIDC
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {

        if let authorizationFlow = self.currentAuthorizationFlow, authorizationFlow.resumeExternalUserAgentFlow(with: url) {
            self.currentAuthorizationFlow = nil
            return true
        }

        return false
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
}
