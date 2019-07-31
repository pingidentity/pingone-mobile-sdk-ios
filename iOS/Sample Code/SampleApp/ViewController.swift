//
//  ViewController.swift
//  SampleApp
//
//  Created by Ping Identity on 3/12/19.
//  Copyright © 2019 Ping Identity. All rights reserved.
//

import UIKit
import MessageUI
import PingOne

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var pairingKeyTextField: UITextField!
    @IBOutlet weak var pairOutlet: UIButton!

    var interaction: UIDocumentInteractionController?

    @IBAction func pairDevice(_ sender: UIButton?) {
        self.view.endEditing(true)
        if let pairingKeyText = pairingKeyTextField.text{
            PingOne.pair(pairingKeyText) { (error) in
                
                var messageTitle: String
                if error == nil{
                    messageTitle = "Device is paired successfully."
                    print("Device is paired")
                }
                else{
                    messageTitle = error!.description
                    print(error!.description)
                }
                
                DispatchQueue.main.async {
                    let pairAlert = UIAlertController(title: nil, message:messageTitle, preferredStyle: .alert)
                    pairAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    pairAlert.view.accessibilityIdentifier = "pair_alert"
                    self.present(pairAlert, animated: true)
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        pairDevice(nil)
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        pairingKeyTextField.delegate = self       
    }
    
    // Call this method if you want to share the PingOne SDK logs with the PingOne support team.
    func shareLogs() {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            DispatchQueue.global(qos: .userInitiated).async {
                let fileURL = dir.appendingPathComponent("pingone.log")
                var filesToShare = [Any]()
                filesToShare.append(fileURL)
                let activityViewController = UIActivityViewController(activityItems: filesToShare, applicationActivities: nil)
                
                DispatchQueue.main.async {
                    self.present(activityViewController, animated: true, completion: nil)
                }
            }
        }
    }
}

