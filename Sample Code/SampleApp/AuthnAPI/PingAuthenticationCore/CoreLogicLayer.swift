//
//  LogicLayer.swift
//  AuthnAPI
//
//  Copyright © 2020 Ping Identity. All rights reserved.
//
//  See LICENSE.txt for the Ping Authentication licensing information.
//

import Foundation
import UIKit

let sharedCoreLogicLayer = CoreLogicLayer()

final class CoreLogicLayer: NSObject {
    
    private let comm = CommunicationManager()
    private var timer = Timer()
    private var didTimerStopped = false
    private var timerSecCounter = 0
    private var authCompletion: ((AuthenticationState?, NSError?) -> Void)?
    
    func setAction(_ action: AuthAction?, actionCompletion: @escaping (_ response: AuthenticationState?, NSError?) -> Void) {
        
        switch action {
   
        case .checkUsernamePassword:
            login { (response, error) in
                actionCompletion(response, error)
            }
            
        case .authenticate:
            authenticate { (response, error) in
                self.authCompletion = actionCompletion
                actionCompletion(response, error)
            }
            
        case .poll:
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.didTimerStopped = false
                self.poll()
            }
            
        case .continueAuthentication:
            continueAuthentication() { (response, error) in
                actionCompletion(response, error)
            }
            
        case .cancelAuthentication:
            cancelAuthentication() { (response, error) in
                actionCompletion(response, error)
            }
            
        case .checkOtp:
            checkOtp { (response, error) in
                actionCompletion(response, error)
            }
            
        case .deviceSelectionRequired:
            selectDevice { (response, error) in
                actionCompletion(response, error)
            }
        default:
            startFlow { (response, error) in
                actionCompletion(response, error)
            }
        }
    }
    
    // MARK: requests handling
    
    private func startFlow(completionHandler: @escaping(_ response: AuthenticationState?, NSError?) -> Void) {
        
        let getFlowIdRequestParams = RequestParams.init(urlStr: Config.oidcIssuer)
        
        comm.post(requestParams: getFlowIdRequestParams, headerContentType: Identifiers.ContentTypeInitAuth, needUrlEncode: false) { (response, error) in

            if let errorObj = error {
               completionHandler(nil, errorObj)
            }
            
            if let responseDict = response {
                authenticationState.parseResponse(responseDict)
                
                if let authorizeResponse = responseDict[Response.authorizeResponse] as? [String: Any] {
                    if let accessToken = authorizeResponse[Response.accessToken] as? String {
                        authenticationState.accessToken = accessToken
                    }
                }
                
                if let code = responseDict[Response.code] as? String {
                    authenticationState.code = code
                }
                
                completionHandler(authenticationState, nil)
            }
        }
    }
    
    private func login(completionHandler: @escaping (_ response: AuthenticationState?, NSError?) -> Void) {
        
        guard let username = requestParams.userName, let password = requestParams.password, let flowID = requestParams.flowId else {
            return completionHandler(nil, nil)
        }
        
        let loginRequestParams = RequestParams.init(username: username, password: password, flowID: flowID)
        requestParams.name = loginRequestParams.name
        
        comm.post(requestParams: loginRequestParams, headerContentType: Identifiers.ContentTypeLogin, needUrlEncode: false) { (response, error) in
            
            self.handleResponse(response, error) { (authState, erorr) in
                completionHandler(authState, erorr)
            }
        }
    }
    
    private func checkOtp(completionHandler: @escaping (_ response: AuthenticationState?, NSError?) -> Void) {
        guard let otpValue = requestParams.otp, let flowID = requestParams.flowId else {
            return completionHandler(nil, nil)
        }
        
        let otpRequestParams = RequestParams.init(otp: otpValue, flowID: flowID)
        requestParams.name = otpRequestParams.name

        comm.post(requestParams: otpRequestParams, headerContentType: Identifiers.ContentTypeOTP, needUrlEncode: false) { (response, error) in

            self.handleResponse(response, error) { (authState, erorr) in
                completionHandler(authState, erorr)
            }
        }
    }
        
    private func selectDevice(completionHandler: @escaping (_ response: AuthenticationState?, NSError?) -> Void) {
        
        guard let deviceId = requestParams.deviceId, let flowID = requestParams.flowId else {
            return completionHandler(nil, nil)
        }
        
        let selectDeviceRequestParams = RequestParams.init(deviceId: deviceId, mobilePayload: requestParams.mobilePayload, flowID: flowID)

        comm.post(requestParams: selectDeviceRequestParams, headerContentType: Identifiers.ContentTypeSelectDevice, needUrlEncode: false) { (response, error) in

            self.handleResponse(response, error) { (authState, erorr) in
                completionHandler(authState, erorr)
            }
        }
    }
    
    private func authenticate(completionHandler: @escaping (_ response: AuthenticationState?, NSError?) -> Void) {
        
        guard let flowID = requestParams.flowId else {
            return completionHandler(nil, nil)
        }
        
        let autheticateRequestParams = RequestParams.init(mobilePayload: requestParams.mobilePayload, flowID: flowID)
        
        comm.post(requestParams: autheticateRequestParams, headerContentType: Identifiers.ContentTypeAuthenticate, needUrlEncode: false) { (response, error) in

            self.handleResponse(response, error) { (authState, erorr) in
                completionHandler(authState, erorr)
            }
        }
    }
    
    private func continueAuthentication(completionHandler: @escaping (_ response: AuthenticationState?, NSError?) -> Void) {
        
        guard let flowID = requestParams.flowId else {
            return completionHandler(nil, nil)
        }
        
        let continueRequestParams = RequestParams.init(flowID: flowID)
        continueRequestParams.name = Identifiers.PathNameContinueAuth
        
        comm.post(requestParams: continueRequestParams, headerContentType: Identifiers.ContentTypeContinueAuth, needUrlEncode: false) { (response, error) in
            
            if let errorObj = error {
               completionHandler(nil, errorObj)
            }

            if let responseDict = response {
                authenticationState.parseResponse(responseDict)
                
                if authenticationState.accessToken != nil { // Try parsing access token
                    completionHandler(authenticationState, nil)
                } else {  // If code parameter has a value, run getAuthnToken
                   
                    guard let code = authenticationState.code else {
                        return completionHandler(authenticationState, nil)
                    }
                    self.getAuthnToken(code) { (response, error) in
                        if error == nil {
                            completionHandler(response, nil)
                        }
                    }
               }
            }
        }
    }
    
    private func getAuthnToken(_ code: String, completionHandler: @escaping (_ response: AuthenticationState?, NSError?) -> Void) {

        let getAuthnTokenRequestParams = RequestParams.init(code: code)
        getAuthnTokenRequestParams.name = Identifiers.PathNameGetToken
        
        comm.post(requestParams: getAuthnTokenRequestParams, headerContentType: Identifiers.ContentTypeUrlencoded, needUrlEncode: true) { (response, error) in

            if let errorObj = error {
               completionHandler(nil, errorObj)
            }

            if let responseDict = response {
                authenticationState.parseResponse(responseDict)
                authenticationState.status = .tokenExchangeCompleted
                completionHandler(authenticationState, nil)
            }
            completionHandler(nil, nil)
        }
    }
    
    private func cancelAuthentication(completionHandler: @escaping (_ response: AuthenticationState?, NSError?) -> Void) {
        
        guard let flowID = requestParams.flowId else {
            return completionHandler(nil, nil)
        }
        let cancelRequestParams = RequestParams.init(flowID: flowID)
        cancelRequestParams.name = Identifiers.PathNameCancelAuth
        
        comm.post(requestParams: cancelRequestParams, headerContentType: Identifiers.ContentTypeCancelAuth, needUrlEncode: false) { (response, error) in

            self.handleResponse(response, error) { (authState, erorr) in
                completionHandler(authState, erorr)
            }
        }
    }
    
    private func handleResponse(_ response: [String: Any]?, _ error: NSError?, completionHandler: @escaping (_ response: AuthenticationState?, NSError?) -> Void) {
        if let errorObj = error {
           completionHandler(nil, errorObj)
        }

        if let responseDict = response {
            authenticationState.parseResponse(responseDict)
            completionHandler(authenticationState, nil)
        }
        completionHandler(nil, nil)
    }
    
    @objc private func poll() {
        
        if timerSecCounter >= Identifiers.pollingMaxCounter {
            authenticationState.status = .pushConfirmationTimedout
            
            if var actionsArray = authenticationState.actions {
                if let index = actionsArray.firstIndex(where: { $0 == .poll }) {
                    actionsArray.remove(at: index)
                }
                authenticationState.actions = actionsArray
            }
            
            stopPolling()
        }
        
        if let flowId = requestParams.flowId {
            let pollRequestParams = RequestParams.init(flowID: flowId)
            pollRequestParams.name = Identifiers.PathNamePoll
            
            comm.post(requestParams: pollRequestParams, headerContentType: Identifiers.ContentTypePoll, needUrlEncode: false) { (response, error) in
                
                self.timerSecCounter += 1
                print("polling attempts: \(self.timerSecCounter)")
                
                if let errorObj = error {
                    if let completion = self.authCompletion {
                        self.stopPolling()
                        completion(nil, errorObj)
                    }
                } else {
                    if !self.isTimerValid() { // Start polling timer only if no error and timer was not initiated yet
                        self.startPollingTimer()
                    }
                    
                    if let responseDict = response {
                        authenticationState.parseResponse(responseDict)
                        
                        if authenticationState.status == .pushConfirmationWaiting {
                            // Don't stop polling, untill timerSecCounter will be expired
                        } else {
                            self.stopPolling()
                        }
                    }
                }

            }
        }
    }
    
    private func startPollingTimer() {
        DispatchQueue.main.async {
            if self.didTimerStopped {
                return
            }
            
            let seconds = 1.0
            self.timer = Timer.scheduledTimer(timeInterval: seconds, target: self, selector: #selector(CoreLogicLayer.poll), userInfo: nil, repeats: true)
        }
    }
    
    private func stopPolling() {
        DispatchQueue.main.async {
            self.didTimerStopped = true
            self.timer.invalidate()
            self.timerSecCounter = 0
            
            if let completion = self.authCompletion {
                completion(authenticationState, nil)
            }
        }
    }
    
    private func isTimerValid() -> Bool {
        if self.timer.isValid {
            return true
        }
        return false
    }
    
}
