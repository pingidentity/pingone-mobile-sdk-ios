//
//  Request.swift
//  AuthnAPI
//
//  Copyright © 2020 Ping Identity. All rights reserved.
//
//  See LICENSE.txt for the Ping Authentication licensing information.
//

import Foundation

public class RequestParams {
    
    var urlString = Config.oidcIssuer
    var params: [String: Any]?
    var name: String?
    var userName: String?
    var password: String?
    var dynamicData: String?
    var action: AuthAction?
    var mobilePayload = ""
    var otp: String?
    var flowId: String?
    var deviceId: String?
    

    init(urlStr: String, params: [String: Any]?, name: String?, flowId: String?) {

        self.urlString = urlStr
        self.params = params
        self.name = name
        self.flowId = flowId
    }
    
    required init() {
        self.action = nil
    }
    
    // getFlowId
    convenience init(urlStr: String) {
        
        let protocoloParams = [Identifiers.clientIdKey: Config.clientId, Identifiers.responseTypeKey: Config.responseType, Identifiers.scopeKey: Config.scope, Identifiers.responseMode: Config.responseMode]
        let params: [String: Any] = [Identifiers.ProtocolParameters: protocoloParams]
       
        let completeUrlStr = "\(Config.oidcIssuer)/\(Identifiers.getFlow)?\(Identifiers.responseTypeKey)=\(Config.responseType)&\(Identifiers.clientIdKey)=\(Config.clientId)&\(Identifiers.scopeKey)=\(Config.scope)&\(Identifiers.responseMode)=\(Config.responseMode)"
        
        self.init(urlStr: completeUrlStr, params: params, name: Identifiers.PathNameFlows, flowId: nil)
    }
    
    // Login
    convenience init(username: String, password: String, flowID: String) {
        
        let params = [Identifiers.username: username, Identifiers.password: password]
        
        let completeUrlStr = "\(Config.oidcIssuer)/\(Identifiers.pfWs)/\(Identifiers.authn)/\(Identifiers.PathNameFlows)/\(flowID)"
        self.init(urlStr: completeUrlStr, params: params, name: Identifiers.PathNameLogin, flowId: flowID)
    }
    
    // OTP
    convenience init(otp: String, flowID: String) {
        
        let params = [Identifiers.otp: otp]
        
        let completeUrlStr = "\(Config.oidcIssuer)/\(Identifiers.pfWs)/\(Identifiers.authn)/\(Identifiers.PathNameFlows)/\(flowID)"
        self.init(urlStr: completeUrlStr, params: params, name: Identifiers.PathNameOTP, flowId: flowID)
    }
    
    // SelectDevice
    convenience init(deviceId: String, mobilePayload: String, flowID: String) {
        
        let params = [Identifiers.deviceRef: [Identifiers.id: deviceId], Identifiers.mobilePayloadKey: mobilePayload] as [String: Any]
        
        let completeUrlStr = "\(Config.oidcIssuer)/\(Identifiers.pfWs)/\(Identifiers.authn)/\(Identifiers.PathNameFlows)/\(flowID)"
        self.init(urlStr: completeUrlStr, params: params, name: Identifiers.PathNameSelectDevice, flowId: flowID)
    }
    
    // Authenticate
    convenience init(mobilePayload: String, flowID: String) {
        
        let params = [Identifiers.mobilePayloadKey: mobilePayload]
        
        let completeUrlStr = "\(Config.oidcIssuer)/\(Identifiers.pfWs)/\(Identifiers.authn)/\(Identifiers.PathNameFlows)/\(flowID)"
        self.init(urlStr: completeUrlStr, params: params, name: Identifiers.PathNameAuthenticate, flowId: flowID)
    }
    
    // Polling, CancelAuthentication, ContinueAuthentication
    convenience init(flowID: String) {
        let completeUrlStr = "\(Config.oidcIssuer)/\(Identifiers.pfWs)/\(Identifiers.authn)/\(Identifiers.PathNameFlows)/\(flowID)"
        self.init(urlStr: completeUrlStr, params: nil, name: Identifiers.PathNamePoll, flowId: flowID)
    }
    
    // GetAuthnToken
    convenience init(code: String) {
        
        let params = [Identifiers.AuthnTokenCodeKey: code,
                      Identifiers.grantTypeKey: Config.grantType,
                      Identifiers.clientIdKey: Config.clientId,
                      Identifiers.clientSecretKey: Config.clientSecret]
        
        let completeUrlStr = "\(Config.oidcIssuer)/\(Identifiers.getToken)"
        self.init(urlStr: completeUrlStr, params: params, name: Identifiers.PathNameGetToken, flowId: nil)
    }
}
