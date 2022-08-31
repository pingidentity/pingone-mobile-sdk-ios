//
//  AuthConstants.swift
//  AuthnAPI
//
//  Copyright © 2020 Ping Identity. All rights reserved.
//
//  See LICENSE.txt for the Ping Authentication licensing information.
//

import Foundation

public enum AuthStatus: String {
    case usernamePasswordRequired       = "USERNAME_PASSWORD_REQUIRED"   
    case authenticationRequired         = "AUTHENTICATION_REQUIRED"
    case deviceSelectionRequired        = "DEVICE_SELECTION_REQUIRED"
    case otpRequired                    = "OTP_REQUIRED"
    case pushConfirmationWaiting        = "PUSH_CONFIRMATION_WAITING"
    case pushConfirmationTimedout       = "PUSH_CONFIRMATION_TIMED_OUT"
    case pushConfirmationRejected       = "PUSH_CONFIRMATION_REJECTED"
    case mfaCompleted                   = "MFA_COMPLETED"
    case completed                      = "COMPLETED"
    case mfaFailed                      = "MFA_FAILED"
    case failed                         = "FAILED"
    case mobileParingRequired           = "MOBILE_PAIRING_REQUIRED"
    case mobileParingStarted            = "MOBILE_PAIRING_STARTED"
    case mobileParingCompleted          = "MOBILE_PAIRING_COMPLETED"
    case errorReceived                  = "ERROR_RECEIVED"
    case tokenExchangeCompleted         = "TOKEN_EXCHANGE_COMPLETED"
}

public enum AuthAction: String {
    case selfAction                     = "self" 
    case checkUsernamePassword          = "checkUsernamePassword" 
    case authenticate                   = "authenticate"
    case poll                           = "poll"
    case continueAuthentication         = "continueAuthentication"
    case cancelAuthentication           = "cancelAuthentication"
    case checkOtp                       = "checkOtp"
    case deviceSelectionRequired        = "selectDevice"
}

public enum AuthError: String {
    case validationError                = "VALIDATION_ERROR"
}

struct Identifiers {
    
    static let pfWs                       = "pf-ws"
    static let authn                      = "authn"
    static let getFlow                    = "as/authorization.oauth2"
    static let headerXSRF                 = "X-XSRF-Header"
    static let typeTest                   = "test"

    // Requests
    static let Post                       = "POST"
    static let ContentType                = "Content-Type"
    static let Accept                     = "Accept"
    
    // GetFlowId
    static let flowId                     = "flowId"
    static let PathNameFlows              = "flows"
    static let ContentTypeInitAuth        = "application/vnd.pingidentity.initiateOAuthAuthorization+json"
    static let ContentTypeAuthenticate    = "application/vnd.pingidentity.authenticate+json"
    static let ContentTypeContinueAuth    = "application/vnd.pingidentity.continueAuthentication+json"
    static let ContentTypePoll            = "application/vnd.pingidentity.poll+json"
    static let ContentTypeCancelAuth      = "application/vnd.pingidentity.cancelAuthentication+json"
    static let ContentTypeSelectDevice    = "application/vnd.pingidentity.selectDevice+json"
    static let ContentTypeUrlencoded      = "application/x-www-form-urlencoded"
    static let ProtocolParameters         = "protocolParameters"
    static let clientIdKey                = "client_id"
    static let responseTypeKey            = "response_type"
    static let responseMode               = "response_mode"
    static let scopeKey                   = "scope"
    
    // Version
    static let versionName                = "v1.0.0"
    
    // Login
    static let loginTitle                 = "Sign On"
    static let PathNameLogin              = "Login"
    static let username                   = "username"
    static let usernameFieldPlaceholder   = "USERNAME"
    static let password                   = "password"
    static let passwordFieldPlaceholder   = "PASSWORD"
    static let signOnBtnText              = "Sign On"
    static let ContentTypeLogin           = "application/vnd.pingidentity.checkUsernamePassword+json"
    
    // Authenticate
    static let PathNameAuthenticate       = "Authenticate"
    static let mobilePayloadKey           = "mobilePayload"
    
    // Pairing
    static let pingIdPayload              = "pingIdPayload"
    
    // ContinueAuthenticate
    static let PathNameContinueAuth       = "continueAuthenticate"
    
    // OTP
    static let PathNameOTP                = "checkOTP"
    static let otp                        = "otp"
    static let otpPlaceholder             = "Insert OTP"
    static let otpSubmitBtnText           = "Check OTP"
    static let ContentTypeOTP             = "application/vnd.pingidentity.checkOtp+json"
    
    // SelectDevices
    static let PathNameSelectDevice       = "SelectDevice"
    static let deviceId                   = "deviceId"
    static let id                         = "id"
    static let deviceRef                  = "deviceRef"
    
    // Poll
    static let PathNamePoll               = "Poll"
    static let pollingCode                = "code"
    static let pollingMaxCounter          = 15
    
    // CancelAuthenticate
    static let PathNameCancelAuth         = "CancelAuthentication"
    
    // GetAuthnToken
    static let PathNameGetToken           = "GetAuthnToken"
    static let getToken                   = "as/token.oauth2"
    static let AuthnTokenCodeKey          = "code"
    static let grantTypeKey               = "grant_type"
    static let clientSecretKey            = "client_secret"
    
    // Error
    static let messageKey                 = "message"
    static let errorTitle                 = "ERROR"
    static let errorDomainPingOne         = "PingOneErrorDomain"
    static let missingCredMsg             = "Please remove placeholders from Config file and add your own credentials."
    
    // Placeholders
    static let issuerPlaceholder          = "<issuerPlaceHolder>"
    static let clientPlaceholder          = "<clientIdPlaceHolder>"
}


struct Response {
    static let status                     = "status"
    static let serverPayload              = "serverPayload"
    static let code                       = "code"
    static let userMessage                = "userMessage"
    static let message                    = "message"
    static let accessToken                = "access_token"
    static let authorizeResponse          = "authorizeResponse"
    static let details                    = "details"
}

struct Flow {
    static let id                         = "id"
    static let status                     = "status"
    static let devices                    = "devices"
    static let user                       = "user"
    static let links                      = "_links"
    static let serverPayload              = "serverPayload"
}

struct UserKeys {
    static let id                         = "id"
    static let firstName                  = "firstName"
    static let lastName                   = "lastName"
    static let username                   = "username"
    static let status                     = "status"
    static let lastLogin                  = "lastLogin"
}

struct DeviceKeys {
    static let id                         = "id"
    static let name                       = "name"
    static let type                       = "type"
    static let target                     = "target"
    static let nickname                   = "nickname"
    static let enrollmentTime             = "enrollmentTime"
    static let applicationId              = "namapplicationIde"
    static let bypassExpriation           = "bypassExpriation"
    static let bypassed                   = "bypassed"
    static let pushEnabled                = "pushEnabled"
    static let osVersion                  = "osVersion"
    static let applicationVersion         = "applicationVersion"
    static let usable                     = "usable"
}

struct ViewControllerKeys {
    static let storyboardId               = "AuthMain"
    static let MainVcID                   = "MainVcID"
}
