//
//  UserData.swift
//  AuthnAPI
//
//  Copyright © 2020 Ping Identity. All rights reserved.
//
//  See LICENSE.txt for the Ping Authentication licensing information.
//

import UIKit

struct UserData {
    
    var id: String?
    var firstName: String?
    var lastName: String?
    var userName: String?
    var status: String?
    var lastLogin: Date?
    
    static func getUser(From data: [String: Any]) -> UserData {
        let id = data[UserKeys.id] as? String ?? ""
        let firstName = data[UserKeys.firstName] as? String ?? ""
        let lastName = data[UserKeys.lastName] as? String ?? ""
        let userName = data[UserKeys.username] as? String ?? ""
        let status = data[UserKeys.status] as? String ?? ""
        
        var lastLogin =  Date(timeIntervalSince1970: 0)
        if let lastLoginIntreval = data[UserKeys.lastLogin] as? TimeInterval {
            lastLogin =  Date(timeIntervalSince1970: lastLoginIntreval)
        }
        
        let user = UserData(id: id, firstName: firstName, lastName: lastName, userName: userName, status: status, lastLogin: lastLogin)
        return user
    }
}
