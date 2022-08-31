//
//  PingAuthenticationCore.swift
//  AuthnAPI
//
//  Copyright © 2020 Ping Identity. All rights reserved.
//
//  See LICENSE.txt for the Ping Authentication licensing information.
//
//  Version 1.0.0

import Foundation
import UIKit

var authenticationState = AuthenticationState()
var requestParams = RequestParams()

/**
* This class represents public API’s for the PingAuthenticationCore module
*/

final public class PingAuthenticationCore: NSObject {
    
    /// Authenticate
    ///
    /// Executes a request according to the RequestParams and returns AuthenticationState. The authentication process is determined according to an action, and returns a status from the server.
    ///
    /// - Parameters:
    ///   - requestParams: object that contains all the parameters needed to make an API call. Each action determines the relevant API request that is called in the LogicLayer.
    ///   - completionHandler: returns serverPayload, accessToken and error.
    /// - Returns:
    ///   - response: response parameters object which contains the API response status and array of available actions.
    ///   - error: error object in cases of error.
    /// - Note:
    ///   If you want to use your own UI, this method can be called independently, regardless of the PingAuthenticationUI instance.
    
    static public func authenticate(_ requestParams: RequestParams, completionHandler: @escaping (_ response: AuthenticationState?, _ error: NSError?) -> Void) {
        
        sharedCoreLogicLayer.setAction(requestParams.action) { (state, error) in
            completionHandler(state, error)
        }
    }
}
