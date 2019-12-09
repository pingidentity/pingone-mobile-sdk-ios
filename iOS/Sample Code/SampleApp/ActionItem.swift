//
//  ActionItem.swift
//  SampleApp
//
//  Created by Ping Identity on 10/10/19.
//  Copyright © 2019 Ping Identity. All rights reserved.
//

import UIKit

class ActionItem: NSObject {

    var actionName:     String
    var segueID:        String
    
    init(actionName: String, segueID : String) {
        self.actionName = actionName
        self.segueID = segueID
    }
}
