//
//  UsersHandler.swift
//  SampleApp
//
//  Created by Ping Identity on 17/01/2022.
//  Copyright © 2022 Ping Identity. All rights reserved.
//

import Foundation

class UsersHandler {
    
    func createUsersArray(_ users: [[String: Any]]) -> [User] {
        var usersArray = [User]()
        
        for user in users {
            guard let usersData = try? JSONSerialization.data(withJSONObject: user, options: []) else {
                continue
            }
            guard let userResponse = try? JSONDecoder().decode(User.self, from: usersData) else {
                continue
            }
            let userId = userResponse.id
            let userEmail = userResponse.email
            let given = userResponse.name?.given
            let family = userResponse.name?.family
            let username = userResponse.username
            let newUser = User.init(id: userId, email: userEmail, username: username, name: Name.init(given: given, family: family))
            
            usersArray.append(newUser)
        }
        return usersArray
    }
}
