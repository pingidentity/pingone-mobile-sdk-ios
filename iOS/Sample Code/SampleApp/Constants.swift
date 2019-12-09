//
//  Constants.swift
//  SampleApp
//
//  Created by Ping Identity on 10/10/19.
//  Copyright © 2019 Ping Identity. All rights reserved.
//

import Foundation

struct OIDC {
    /**
     The OIDC issuer from which the configuration will be discovered.
     For example: "https://auth.pingone.com/1e41d166-8012-4fa2-b755-15cd7c8a03de/as"
    */
    static let Issuer                  = "YOUR_ISSUER"
    /**
     The OAuth client ID.
     For example: "4a43c047-36f9-4d86-a53e-273a4d28d629"
    */
    static let ClientID                = "YOUR_CLIENT_ID"
    /**
     The OAuth redirect URI for the ClientID.
     For example: "pingonesdk://sample"
    */
    static let RedirectURI             = "YOUR_REDIRECT_URI"
}

struct OIDCKey {
    static let MobilePayload            = "mobilePayload"
}

struct PairingMethodName {
    static let Manual                   = "Manual Pairing"
    static let OIDC                     = "OIDC Automatic Pairing"
}

struct SegueName {
    static let Manual                   = "manual"
    static let OIDC                     = "oidc"
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
}

