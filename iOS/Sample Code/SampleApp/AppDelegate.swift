//
//  AppDelegate.swift
//  SampleApp
//
//  Created by Ping Identity on 3/12/19.
//  Copyright © 2019 Ping Identity. All rights reserved.
//

import UIKit
import UserNotifications
import PingOne

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.registerRemoteNotifications()
        
        return true
    }
    
    func registerRemoteNotifications()
    {
        print("Registering remote notifications")
        
        let center  = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
            if error == nil
            {
                // Registering UNNotificationCategories more than once results in previous categories being overwritten. PingOne provides the needed categories. The developer may add categories.
                UNUserNotificationCenter.current().setNotificationCategories(PingOne.getUNNotificationCategories())
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    }
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error)
    {
        print(error.localizedDescription)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let deviceTokenString = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("Device Token: \(deviceTokenString)")

        var deviceTokenType : PingOne.APNSDeviceTokenType = .production
        #if DEBUG
        deviceTokenType = .sandbox
        #endif
        
        PingOne.setDeviceToken(deviceToken, type: deviceTokenType) { (error) in
            if let error = error{
                print(error.localizedDescription)
            }
        }
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void)
    {
        print("didReceive")
        
        PingOne.processRemoteNotificationAction(response.actionIdentifier, forRemoteNotification: response.notification.request.content.userInfo) { (notificationObject, error) in
            
            if let error = error{
                print("Error: \(String(describing: error))")
                if error.code == ErrorCode.unrecognizedRemoteNotification.rawValue{
                    //Do something else with remote notification.
                }
            }
            else if let notificationObject = notificationObject{ //User pressed the actual banner, instead of an action.
                self.displayNotificationViewAlert(notificationObject)
            }
            completionHandler()
        }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void)
    {
        print("didReceiveRemoteNotification userinfo: \(userInfo)")
        
        PingOne.processRemoteNotification(userInfo) { (notificationObject, error) in
            if let error = error{
                print("Error: \(String(describing: error))")
                if error.code == ErrorCode.unrecognizedRemoteNotification.rawValue{
                    //Unrecognized remote notification.
                    completionHandler(UIBackgroundFetchResult.noData)
                }
            }
            else if let notificationObject = notificationObject{
                switch(notificationObject.notificationType){
                case .authentication:
                    self.displayNotificationViewAlert(notificationObject)
                    completionHandler(UIBackgroundFetchResult.newData)

                default:
                    print("Error: \(String(describing: error))")
                    completionHandler(UIBackgroundFetchResult.noData)
                }
            }
            else{
                completionHandler(UIBackgroundFetchResult.noData)
            }
        }
    }
    
    func displayNotificationViewAlert(_ notificationObject: NotificationObject){
        DispatchQueue.main.async {
            let authAlert = UIAlertController(title: "Authenticate?", message: nil, preferredStyle: .alert)
            
            let approveAction = UIAlertAction(title: "Approve", style: UIAlertAction.Style.default) {
                UIAlertAction in
                print("Approve Pressed")
                notificationObject.approve(completionHandler: { (error) in
                    if error != nil
                    {
                        print("Error: \(String(describing: error))")
                    }
                })
            }
            let denyAction = UIAlertAction(title: "Deny", style: UIAlertAction.Style.cancel) {
                UIAlertAction in
                print("Deny Pressed")
                notificationObject.deny(completionHandler: { (error) in
                    if error != nil
                    {
                        print("Error: \(String(describing: error))")
                    }
                })
            }
            authAlert.addAction(approveAction)
            authAlert.addAction(denyAction)
            authAlert.view.accessibilityIdentifier = "auth_alert"
            self.window?.rootViewController?.present(authAlert, animated: true, completion: nil)
        }
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

