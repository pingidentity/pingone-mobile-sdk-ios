//
//  Alert.swift
//  SampleApp
//
//  Created by Ping Identity on 10/29/19.
//  Copyright © 2019 Ping Identity. All rights reserved.
//

import UIKit
import Foundation

struct Alert {
    static func generic(viewController: UIViewController, title: String? = nil, message: String?, error: NSError?) {
        
        var titleCustmized = Local.Success
        if title != nil {
            titleCustmized = title ?? ""
        }
        
        var alertMessage = ""
        
        if error != nil {
            titleCustmized = Local.Error
            alertMessage = error!.description
            print(error!.description)
        } else if message != nil {
            alertMessage = message!
        }
        
        DispatchQueue.main.async {
            let pairAlert = UIAlertController(title: titleCustmized, message: alertMessage, preferredStyle: .alert)
            pairAlert.addAction(UIKit.UIAlertAction(title: Local.Ok, style: .default, handler: nil))
            pairAlert.view.accessibilityIdentifier = "generic_alert"
            pairAlert.view.accessibilityValue = "\(titleCustmized)-\(alertMessage)"
            viewController.present(pairAlert, animated: true)
        }
    }
    
    static func genericWithCompletion(viewController: UIViewController, title: String? = nil, message: String?, error: NSError?, completionHandler: @escaping () -> Void) {
           
        var titleCustmized = Local.Success
        if let title = title {
            titleCustmized = title
        }
        
        var alertMessage = ""
        if let message = message {
            alertMessage = message
        }
       
        if let error = error {
            titleCustmized = Local.Error
            alertMessage = error.description
            print(error.description)
        }
       
        DispatchQueue.main.async {
           let pairAlert = UIAlertController(title: titleCustmized, message: alertMessage, preferredStyle: .alert)
           pairAlert.addAction(UIKit.UIAlertAction(title: Local.Ok, style: .default, handler: { (action) in
               completionHandler()
           }))
           pairAlert.view.accessibilityIdentifier = "generic_alert"
           pairAlert.view.accessibilityValue = "\(titleCustmized)-\(alertMessage)"
           viewController.present(pairAlert, animated: true)
        }
    }
    
    static func approveDeny(viewController: UIViewController, title: String, message: String? = nil, completionHandler: @escaping (_ approved: Bool?) -> Void) {
        DispatchQueue.main.async {
            let authAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let approveAction = UIAlertAction(title: Local.Approve, style: UIAlertAction.Style.default) { UIAlertAction in
                print("Approve Pressed")
                completionHandler(true)
            }
            let denyAction = UIAlertAction(title: Local.Deny, style: UIAlertAction.Style.destructive) { UIAlertAction in
                print("Deny Pressed")
                completionHandler(false)
            }
            let cancelAction = UIAlertAction(title: Local.Cancel, style: UIAlertAction.Style.cancel) { UIAlertAction in
                print("Cancel Pressed")
                completionHandler(nil)
            }
            authAlert.addAction(approveAction)
            authAlert.addAction(denyAction)
            authAlert.addAction(cancelAction)
            authAlert.view.accessibilityIdentifier = "auth_alert"
            authAlert.view.accessibilityValue = "\(title)"
            viewController.present(authAlert, animated: true, completion: nil)
        }
    }
    
    static func genericApproveWithDismiss(viewController: UIViewController, title: String?, message: String?, error: NSError?, completionHandler: @escaping () -> Void) {
        DispatchQueue.main.async {
            var titleCustmized = Local.Success
            if let title = title {
                titleCustmized = title
            }
            
            var alertMessage = ""
            if let message = message {
                alertMessage = message
            }
           
            if let error = error {
                titleCustmized = Local.Error
                alertMessage = error.description
                print(error.description)
            }
            
            let dismissAction = UIAlertAction(title: Local.Ok, style: UIAlertAction.Style.default) { UIAlertAction in
                completionHandler()
            }
            
            let generalAlert = UIAlertController(title: titleCustmized, message: alertMessage, preferredStyle: .alert)
            
            generalAlert.addAction(dismissAction)
            generalAlert.view.accessibilityIdentifier = "auth_alert"
            generalAlert.view.accessibilityValue = "\(titleCustmized)"
            viewController.present(generalAlert, animated: true, completion: nil)
        }
    }
    
    static func genericWithDismiss(viewController: UIViewController, title: String?, message: String?, error: NSError?, completionHandler: @escaping () -> Void) {
        DispatchQueue.main.async {
            var titleCustmized = Local.Success
            if let title = title {
                titleCustmized = title
            }
            
            var alertMessage = ""
            if let message = message {
                alertMessage = message
            }
           
            if let error = error {
                titleCustmized = Local.Error
                alertMessage = error.description
                print(error.description)
            }
            
            let generalAlert = UIAlertController(title: titleCustmized, message: alertMessage, preferredStyle: .alert)
            
            let dismissAction = UIAlertAction(title: Local.Ok, style: UIAlertAction.Style.default) { UIAlertAction in
                completionHandler()
            }
            
            generalAlert.addAction(dismissAction)
            generalAlert.view.accessibilityIdentifier = "auth_alert"
            generalAlert.view.accessibilityValue = "\(titleCustmized)"
            viewController.present(generalAlert, animated: true, completion: nil)
        }
    }
}
