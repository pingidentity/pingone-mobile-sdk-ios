//
//  ActionItem.swift
//  SampleApp
//
//  Created by Ping Identity on 10/10/19.
//  Copyright © 2019 Ping Identity. All rights reserved.
//

import UIKit

class ActionItem: NSObject {

    enum ActionItemType {
        case segue
        case sendLogs
    }
    
    var actionName: String
    var segueID: String?
    var type: ActionItemType
    
    init(actionName: String, segueID: String?, actionType: ActionItemType) {
        self.actionName = actionName
        self.type       = actionType
        if let segueID = segueID {
            self.segueID = segueID
        }
    }
}
