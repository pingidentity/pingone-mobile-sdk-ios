//
//  UILogicLayer.swift
//  AuthnAPI
//
//  Copyright © 2020 Ping Identity. All rights reserved.
//
//  See LICENSE.txt for the Ping Authentication licensing information.
//

import UIKit

let sharedUILogicLayer = UILogicLayer()

final class UILogicLayer: NSObject {
    
    var needToPresentVC = true
    
    func authenticate(request: RequestParams, completionHandler: @escaping (_ response: AuthenticationState?, _ error: NSError?) -> Void) {
        PingAuthenticationCore.authenticate(request) { (response, error) in
            
            if let error = error {
                completionHandler(nil, error)
            }
            
            if let response = response {
                if self.needToPresentVC && authenticationState.status != .errorReceived {
                    self.showMainVC()
                    
                }
                self.needToPresentVC = true
                completionHandler(response, nil)
            }
        }
    }
    
    func continueAuthentication() {
        showMainVC()
    }
 
    private func showMainVC() {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard.init(name: ViewControllerKeys.storyboardId, bundle: nil)
            if let mainVC = storyboard.instantiateViewController(withIdentifier: ViewControllerKeys.MainVcID) as? MainAuthViewController {
                if let presenter = authenticationState.authenticatorAppVC {
                    mainVC.modalPresentationStyle = .overCurrentContext
                    mainVC.modalTransitionStyle = .crossDissolve
                    mainVC.completion = authenticationState.authCompletion
                    
                    presenter.present(mainVC, animated: true, completion: nil)
                }
            }
        }
    }
}
