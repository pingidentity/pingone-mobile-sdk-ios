//
//  Constants.swift
//  SampleApp
//
//  Created by Ping Identity on 10/10/19.
//  Copyright © 2019 Ping Identity. All rights reserved.
//

import Foundation

struct OIDC {
    static let Issuer                  = "https://auth.pingone.com/9431bc59-ace5-44f7-a71f-60bc6afb0535/as"
    static let ClientID                = "f26dde36-5e65-442e-b7e6-7a3b2c92266d"
    static let RedirectURI             = "pingonesdk://sample"
}

struct OIDCKey {
    static let MobilePayload            = "mobilePayload"
}

struct PairingMethodName {
    static let Manual                   = "Manual Pairing"
    static let OIDC                     = "OIDC Automatic Pairing"
}

struct AuthnAPIName {
    static let authnAPI                 = "Authentication API"
}

struct SDKFunctionality {
    static let SendLogs                 = "SendLogs"
}

struct SegueName {
    static let Manual                   = "manual"
    static let OIDC                     = "oidc"
    static let authnAPI                 = "authnapi"
}

struct Local {
    static let DeviceIsPaired                   = "Device is paired successfully."
    static let Pair                             = "Pair?"
    static let Authenticate                     = "Authenticate?"
    static let Approve                          = "Approve"
    static let Deny                             = "Deny"
    static let Cancel                           = "Cancel"
    static let Success                          = "SUCCESS"
    static let Error                            = "ERROR"
    static let Ok                               = "OK"
    static let appTitle                         = "PingOne Sample Application"
}

struct Push {
    static let aps                     = "aps"
    static let alert                   = "alert"
    static let title                   = "title-loc-key"
    static let body                    = "loc-key"
}

