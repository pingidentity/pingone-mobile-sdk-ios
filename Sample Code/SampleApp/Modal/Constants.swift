//
//  Constants.swift
//  SampleApp
//
//  Created by Ping Identity on 10/10/19.
//  Copyright © 2019 Ping Identity. All rights reserved.
//

import Foundation

struct OIDC {
    static let Issuer                  = "<#Issuer#>"
    static let ClientID                = "<#clientId#>"
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
    static let OneTimePasscode          = "One Time Passcode"
    static let QRAuth                   = "QR Authentication"
    static let SendLogs                 = "SendLogs"
}

struct SegueName {
    static let Manual                   = "manual"
    static let OIDC                     = "oidc"
    static let authnAPI                 = "authnapi"
    static let passcode                 = "passcode"
    static let QRAuth                   = "QRAuth"
    static let UserApproval             = "UserApproval"
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
    static let AuthCompleted                    = "Authentication completed successfully"
    static let AuthStatusExpired                = "EXPIRED"
    static let AuthStatusClaimed                = "CLAIMED"
    static let AuthStatusCompleted              = "COMPLETED"
    static let AuthUserApprovalNOTRequired      = "NOT_REQUIRED"
    static let AuthUserApprovalRequired         = "REQUIRED"
    static let UserSelectionTitle               = "Do you want to approve authentication for a user"
    static let ClientContextPlaceholder         = "clientContext will be placed here if returned from the SDK"
}

struct Push {
    static let aps                     = "aps"
    static let alert                   = "alert"
    static let title                   = "title-loc-key"
    static let body                    = "loc-key"
}

struct OneTimePasscodeError {
    static let notPaired               = "Device Not Paired"
}
