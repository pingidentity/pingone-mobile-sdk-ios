//
//  ViewController.swift
//  SampleApp
//
//  Created by Ping Identity on 3/12/19.
//  Copyright © 2019 Ping Identity. All rights reserved.
//

import UIKit
import PingOneSDK

class ManualPairingViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var pairingKeyTextField: UITextField!
    @IBOutlet weak var pairOutlet: UIButton!

    var interaction: UIDocumentInteractionController?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = PairingMethodName.Manual
        pairingKeyTextField.delegate = self
        pairingKeyTextField.keyboardType = .namePhonePad
        pairingKeyTextField.autocapitalizationType = .allCharacters
    }
    
    @IBAction func pairDevice(_ sender: UIButton?) {
        self.view.endEditing(true)
        sender?.isUserInteractionEnabled = false
        
        if let pairingKeyText = pairingKeyTextField.text {
            PingOne.pair(pairingKeyText) { (reponse, error) in
                DispatchQueue.main.async {
                    sender?.isUserInteractionEnabled = true
                    Alert.generic(viewController: self, message: Local.DeviceIsPaired, error: error)
                }
            }
        } else {
            sender?.isUserInteractionEnabled = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        pairDevice(nil)
        return true
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == pairingKeyTextField {
            if string == "" {
                // User presses backspace
                textField.deleteBackward()
            } else {
                // User presses any key or pastes
                textField.insertText(string.uppercased())
            }
            return false
        }
        return true
    }
}
