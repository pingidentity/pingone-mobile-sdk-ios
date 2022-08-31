//
//  OIDCViewController.swift
//  SampleApp
//
//  Created by Ping Identity on 10/10/19.
//  Copyright © 2019 Ping Identity. All rights reserved.
//

import UIKit
import AppAuth
import PingOneSDK

class OIDCViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = PairingMethodName.OIDC
    }

    @IBAction func pairDevice(_ sender: UIButton) {
        
        guard let issuer = URL(string: OIDC.Issuer) else {
            print("Error creating URL for: \(OIDC.Issuer)")
            return
        }
        OIDAuthorizationService.discoverConfiguration(forIssuer: issuer) { configuration, error in

            guard let config = configuration else {
                print("Error retrieving discovery document: \(error?.localizedDescription ?? "DEFAULT_ERROR")")
                return
            }

            print("Got configuration: \(config)")
            self.doAuthWithAutoCodeExchange(configuration: config, clientID: OIDC.ClientID, clientSecret: nil)
        }
    }
    
    func doAuthWithAutoCodeExchange(configuration: OIDServiceConfiguration, clientID: String, clientSecret: String?) {

        guard let redirectURI = URL(string: OIDC.RedirectURI) else {
            print("Error creating URL for: \(OIDC.RedirectURI)")
            return
        }

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Error accessing AppDelegate")
            return
        }

        do {
            let payload = try PingOne.generateMobilePayload()
            
            // builds authentication request
            let request = OIDAuthorizationRequest(configuration: configuration, clientId: clientID, clientSecret: clientSecret, scopes: [OIDScopeOpenID, OIDScopeProfile], redirectURL: redirectURI, responseType: OIDResponseTypeCode, additionalParameters: [OIDCKey.MobilePayload: payload])

            // performs authentication request
            print("Initiating authorization request with scope: \(request.scope ?? "DEFAULT_SCOPE")")

            appDelegate.currentAuthorizationFlow = OIDAuthState.authState(byPresenting: request, presenting: self) { authState, error in

                if let authState = authState {
                    print("Got authorization tokens. Access token: \(authState.lastTokenResponse?.accessToken ?? "DEFAULT_TOKEN")")
                    // Call PingOne SDK with the idToken
                    self.processIdToken(authState.lastTokenResponse?.idToken ?? "DEFAULT_TOKEN")
                } else {
                    print("Authorization error: \(error?.localizedDescription ?? "DEFAULT_ERROR")")
                }
            }
        } catch let error {
            print(error)
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
        Alert.approveDeny(viewController: self, title: Local.Pair) { (approved) in
            if let approved = approved {
                if approved {
                    pairingObject.approve(completion: { (response, error) in
                        Alert.generic(viewController: self, message: Local.DeviceIsPaired, error: error)
                    })
                }
            }
        }
    }
}
