//
//  Alert.swift
//  SampleApp
//
//  Created by Ping Identity on 10/29/19.
//  Copyright © 2019 Ping Identity. All rights reserved.
//

import UIKit
import Foundation

struct Alert{    
    static func generic(viewController: UIViewController, message: String?, error: NSError?){
        
        var title = Local.Success
        var alertMessage = ""
        
        if error != nil{
            title = Local.Error
            alertMessage = error!.description
            print(error!.description)
        }
        else if message != nil{
            alertMessage = message!
        }
        
        DispatchQueue.main.async {
            let pairAlert = UIAlertController(title: title, message:alertMessage, preferredStyle: .alert)
            pairAlert.addAction(UIKit.UIAlertAction(title: Local.Ok, style: .default, handler: nil))
            pairAlert.view.accessibilityIdentifier = "generic_alert"
            pairAlert.view.accessibilityValue = "\(title)-\(alertMessage)"
            viewController.present(pairAlert, animated: true)
        }
    }
    
    static func genericWithCompletion(viewController: UIViewController, title: String? = nil, message: String?, error: NSError?, completionHandler: @escaping () -> Void){
           
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
    
    static func approveDeny(viewController: UIViewController, title: String, message: String? = nil, completionHandler: @escaping (_ approved: Bool?) -> Void){
        DispatchQueue.main.async {
            let authAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let approveAction = UIAlertAction(title: Local.Approve, style: UIAlertAction.Style.default) {
                UIAlertAction in
                print("Approve Pressed")
                completionHandler(true)
            }
            let denyAction = UIAlertAction(title: Local.Deny, style: UIAlertAction.Style.destructive) {
                UIAlertAction in
                print("Deny Pressed")
                completionHandler(false)
            }
            let cancelAction = UIAlertAction(title: Local.Cancel, style: UIAlertAction.Style.cancel) {
                UIAlertAction in
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
}

