//
//  Config.swift
//  AuthnAPI
//
//  Copyright © 2020 Ping Identity. All rights reserved.
//
//  See LICENSE.txt for the Ping Authentication licensing information.
//

import UIKit

struct Config {
    /**
     The OIDC issuer from which the configuration will be discovered.
     For example: "https://pingfed-auth-demo-api.com:9031"
    */
    static var oidcIssuer              = "<#Issuer#>"
    /**
     The OAuth client ID.
     For example: "4sk02sk7-36a9-39kd-a23e-10ws4msk8ww02""
    */
    static var clientId                = "<#clientId#>"
    
    /**
     Parameters for getFlowId API request
    */
    static let responseType              = "code"
    static let scope                     = "openid"
    static let responseMode              = "pi.flow"
    
    /**
     Parameters for getAuthnToken API request
    */
    static let clientSecret              = "" // Optional. Add the client secret here, according to its configuration in PingFederate.
    static let grantType                 = "authorization_code"
}
