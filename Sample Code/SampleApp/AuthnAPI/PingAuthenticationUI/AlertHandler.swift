//
//  Alert.swift
//  AuthnAPI
//
//  Copyright © 2020 Ping Identity. All rights reserved.
//
//  See LICENSE.txt for the Ping Authentication licensing information.
//

import UIKit

class AlertHandler: NSObject {
    
    private var presenter: UIViewController
    
    init(presenter: UIViewController) {
        self.presenter = presenter
    }
    
    func getStringActions(from actions: [AuthAction]) -> [String] {
        var actionsStringArray = [String]()
        for action in actions {
            let actionStr = action.rawValue
            actionsStringArray.append(actionStr)
        }
        return actionsStringArray
    }

    func showAlertWithOptions(title: String?, message: String?, options: [String], completionHandler: @escaping (_ pickedOption: String, _ optionId: Int) -> Void) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            for option in options {
                let action = UIAlertAction(title: option, style: .default) { (action) in
                    if let optionId = options.firstIndex(where: { $0 == option }) {
                        completionHandler(option, optionId)
                    }
                }
                alert.addAction(action)
            }
            self.presenter.present(alert, animated: true)
        }
    }
       
    func showOKAlert(title: String?, message: String?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIKit.UIAlertAction(title: "OK", style: .default, handler: nil))
            self.presenter.present(alert, animated: true)
        }
    }
    
    func showOKAlertWithCompletion(title: String?, message: String?, completionHandler: @escaping () -> Void) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { (action) in
                    completionHandler()
            }
            alert.addAction(action)
            self.presenter.present(alert, animated: true)
        }
    }
}
