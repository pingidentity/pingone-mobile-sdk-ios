//
//  User.swift
//  SampleApp
//
//  Created by Ping Identity on 14/11/2021.
//  Copyright © 2021 Ping Identity. All rights reserved.
//

import UIKit


struct User: Codable {
    let id, email, username: String?
    var name: Name?
}

struct Name: Codable {
    var given: String?
    var family: String?
}
