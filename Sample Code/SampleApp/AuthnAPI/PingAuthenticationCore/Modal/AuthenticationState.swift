//
//  AuthnApiState.swift
//  AuthnAPI
//
//  Copyright © 2020 Ping Identity. All rights reserved.
//
//  See LICENSE.txt for the Ping Authentication licensing information.
//

import UIKit

final public class AuthenticationState: NSObject {
    
    var authenticatorAppVC: UIViewController?
    var authCompletion: ((String, String, NSError?) -> Void)?
    
    var flowId: String?
    var status: AuthStatus?
    var error: AuthError?
    var code: String?
    var accessToken: String?
    var serverPayload: String?
    var actions: [AuthAction]?
    var devicesNames: [String: String]?
    var user: UserData?
    var errorJsonMsg: String?
    
    func parseResponse(_ responseDict: [String: Any]?) {
        
        if let responseDict = responseDict {
            
            if authenticationState.flowId == nil {
                if let flowId = responseDict[Flow.id] as? String {
                    authenticationState.flowId = flowId
                    requestParams.flowId = flowId
                }
            }
            
            if let status = responseDict[Flow.status] as? String {
                authenticationState.status = AuthStatus.init(rawValue: status)
            }
            
            if let data = responseDict[Flow.devices] as? [[String: Any]] {
                let parsedDevices = DeviceData.getDevices(From: data)
                authenticationState.devicesNames = parsedDevices
            }
            
            if let data = responseDict[Flow.user] as? [String: Any] {
                let parsedUser = UserData.getUser(From: data)
                authenticationState.user = parsedUser
            }
            
            if let linksData = responseDict[Flow.links] as? NSDictionary {
                
                if let actionsStrArray = linksData.allKeys as? [String] {
                    
                    // Convert actions string array into AuthAction enum array
                    var actionsArray = [AuthAction]()
                    for actionStr in actionsStrArray {
                        guard let action = AuthAction.init(rawValue: actionStr) else {
                            continue
                        }
                        actionsArray.append(action)
                    }

                    // Filter actions
                    var actionsArrayFiltered = [AuthAction]()
                    for action in actionsArray {
                        if action == .selfAction || (authenticationState.status == .authenticationRequired && action == .deviceSelectionRequired) { // Currently selectDevice is filtered out for the AUTHENTICATION_REQUIRE status. selectDevice will be supported in future versions.
                            continue
                        } else {
                            actionsArrayFiltered.append(action)
                        }
                    }
                    authenticationState.actions = actionsArrayFiltered
                }
            }
            
            if let serverPayload = responseDict[Flow.serverPayload] as? String {
                authenticationState.serverPayload = serverPayload
            }
            
            if let authorizeResponse = responseDict[Response.authorizeResponse] as? [String: Any] {
                if let accessToken = authorizeResponse[Response.accessToken] as? String {
                    authenticationState.accessToken = accessToken
                }
                if let code = authorizeResponse[Response.code] as? String {
                    authenticationState.code = code
                }
            }
            
            if authenticationState.status == .failed {
                if let code = responseDict[Response.code] as? String {
                    authenticationState.code = code
                }
            }
            
            if let accessToken = responseDict[Response.accessToken] as? String {
                authenticationState.accessToken = accessToken
            }
            
        }
    }
}
