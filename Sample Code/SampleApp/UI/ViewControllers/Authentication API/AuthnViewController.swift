//
//  AuthnViewController.swift
//  SampleApp
//
//  Created by Ping Identity on 26/10/20.
//  Copyright © 2019 Ping Identity. All rights reserved.
//

import UIKit
import PingOneSDK

class AuthnViewController: UIViewController {

    let authnUI =  PingAuthenticationUI()
    let spinner = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = AuthnAPIName.authnAPI
        
        initSpinner()
    }
    
    @IBAction func authnPairBtnWasTapped(_ sender: Any) {
        startAuthnAPI()
    }
    
    // MARK: - handle authnAPI
    
    func startAuthnAPI() {
        startLoadingAnimation()
        
        do {
            let payload = try PingOne.generateMobilePayload()
            authenticate(With: payload)
           } catch let error {
                self.stopLoadingAnimation()
                print(error)
           }
    }
    
    func authenticate(With payload: String) {
        authnUI.authenticate(presenter: self, payload: payload, dynamicData: "") { [weak self] (serverPayload, accessToken, error) in
            guard let self = self else { return }
            
            if serverPayload.count > 0 { // Need pairing
               PingOne.processIdToken(serverPayload) { (pairingObject, error) in
                   self.stopLoadingAnimation()
                   if let pairingObject = pairingObject {
                       self.displayNotificationViewAlert(pairingObject)
                   } else if let error = error {
                       print(error.localizedDescription)
                   }
               }
            } else {
               self.stopLoadingAnimation()
            }
        }
    }
    
    func processIdToken(_ idToken: String) {
        PingOne.processIdToken(idToken) { (pairingObject, error) in
            if let pairingObject = pairingObject {
                self.displayNotificationViewAlert(pairingObject)
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func displayNotificationViewAlert(_ pairingObject: PairingObject) {
        Alert.approveDeny(viewController: self, title: Local.Pair) { approved in
            if let approved = approved {
                if approved {
                    pairingObject.approve(completion: { (response, error) in
                        
                        if error != nil {
                            Alert.generic(viewController: self, message: error.debugDescription, error: error)
                        } else {
                            Alert.genericWithCompletion(viewController: self, message: Local.DeviceIsPaired, error: nil) {
                                // AuthnAPI callback after pairing is done
                                self.authnUI.continueAuthentication(presenter: self)
                            }
                        }
                        
                    })
                }
            }
        }
    }
    
    // MARK: spinner helper methods
    
    func initSpinner() {
        DispatchQueue.main.async {
            if #available(iOS 13.0, *) {
                self.spinner.style = .medium
            } else {
                self.spinner.style = .gray
            }
            
            self.spinner.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(self.spinner)

            if #available(iOS 9.0, *) {
                self.spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
                self.spinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
            } else {
                self.spinner.translatesAutoresizingMaskIntoConstraints = true
                self.spinner.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
            }
        }
    }
    
    func startLoadingAnimation() {
        DispatchQueue.main.async {
            self.spinner.startAnimating()
            self.spinner.isHidden = false
        }
    }
    
 
    func stopLoadingAnimation() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
        
        }
    }

}
