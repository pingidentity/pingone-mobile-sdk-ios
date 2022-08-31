//
//  PingAuthenticationUI.swift
//  AuthnAPI
//
//  Copyright © 2020 Ping Identity. All rights reserved.
//
//  See LICENSE.txt for the Ping Authentication licensing information.
//

import UIKit

/**
* This class represents public API’s for the PingAuthenticationUI module
*/

@objcMembers
final public class PingAuthenticationUI: NSObject {
    
    private weak var authenticatorAppVC: UIViewController?
    private var authCompletion: ((String, String, NSError?) -> Void)?

    
    /// Authenticate
    ///
    /// Starts an authentication process with PingIdentity Authentication API. Calling this method opens a new UIViewController that handles the UI of the authentication process.
    ///
    /// - Parameters:
    ///   - presenter: a UIViewController that retrieves the result of the authentication process.
    ///   - payload: a mobilePayload String retrieved from PingID SDK or PingOne SDK.
    ///   - completionHandler:  returns serverPayload, accessToken and error.
    /// - Returns:
    ///   - serverPayload: server payload String if pairing is needed.
    ///   - accessToken: accessToken String from the Authentication API.
    ///   - error: error object in cases of error.
    
    public func authenticate(presenter: UIViewController, payload: String?, dynamicData: String?, completionHandler: @escaping (_ serverPayload: String, _ accessToken: String, _ error: NSError?) -> Void) {
        
        authenticationState.authenticatorAppVC = presenter
        
        if let mobilePayload = payload {
            requestParams.mobilePayload = mobilePayload
        }
        
        if let dynamicData = dynamicData {
            requestParams.dynamicData = dynamicData
        }
        
        if Config.oidcIssuer == Identifiers.issuerPlaceholder  || Config.clientId == Identifiers.clientPlaceholder {
            print("\(Identifiers.missingCredMsg)")
            completionHandler("", "", nil)
        }
        
        sharedUILogicLayer.authenticate(request: requestParams) { (response, error) in
            
            if let error = error {
                completionHandler("", "", error)
            }
            
            if let response = response {
                if authenticationState.status == .errorReceived {
                    completionHandler("", "", error)
                }
                authenticationState = response
                authenticationState.authCompletion = completionHandler
            }
        }
    }
    
    /// ContinueAuthentication
    ///
    /// Continue an authentication process in the app and returned to the Authentication API instance to finalize the process.
    ///
    /// - Parameters:
    ///   - presenter: a UIViewController that retrieves the result of an authentication process.
    
    public func continueAuthentication(presenter: UIViewController) {
        
        authenticationState.authenticatorAppVC = presenter
        authenticationState.status = .mobileParingCompleted
        sharedUILogicLayer.continueAuthentication()
    }
}
