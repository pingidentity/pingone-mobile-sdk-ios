//
//  UserApprovalViewController.swift
//  SampleApp
//
//  Created by Ping Identity on 14/11/2021.
//  Copyright © 2021 Ping Identity. All rights reserved.
//

import UIKit
import PingOneSDK

class UserApprovalViewController: MainViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var contextLbl: UILabel!
    @IBOutlet weak var usersTableView: DynamicTableView!
    
    private var activeUsersArray = [User]()
    private var selectedUser: User?
    var authObject: AuthenticationObject?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupScreen()
        getUsers()
    }
    
    func setupScreen() {
        usersTableView.delegate = self
        usersTableView.dataSource = self
        usersTableView.separatorColor = UIColor.black
        
        contextLbl.text = Local.ClientContextPlaceholder
        if let context = authObject?.clientContext as? String, context.count > 0 {
            contextLbl.text = context
        }
        
    }
    
    func getUsers() {
        guard let users = authObject?.users else {
            print("No users in the Authentication Object")
            return
        }
        activeUsersArray = UsersHandler().createUsersArray(users)
        usersTableView.reloadData()
    }
    
    // MARK: Handle users table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activeUsersArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: UITableViewCell? = UITableViewCell()
        cell?.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell?.textLabel?.numberOfLines = 0
        
        let user = activeUsersArray[indexPath.row]
        let userName = "id: \(user.id ?? "")\nemail: \(user.email ?? "")\ngiven: \(user.name?.given ?? "")\nfamily: \(user.name?.family ?? "")\nusername: \(user.username ?? "")"
        cell?.textLabel?.text = userName
        
        return cell!
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return usersTableView.cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedUser = activeUsersArray[indexPath.row]
        
        guard let needsApproval = authObject?.userApproval else {
            print("No Authentication Object.")
            return
        }
        
        if needsApproval == Local.AuthUserApprovalNOTRequired { // No need for user approval
            self.approveUserSelected()
            
        } else if needsApproval == Local.AuthUserApprovalRequired {
            
            let title = "\(Local.UserSelectionTitle) \(selectedUser?.id ?? "")"
            Alert.approveDeny(viewController: self, title: title, message: nil) { approved in
                if let approvedResult = approved {
                    if approvedResult {
                        self.approveUserSelected() // APPROVE
                    } else {
                        self.denyUserSelected() // DENY
                    }
                } else { // CANCEL
                    // DO NOTHING
                }
            }
        }
    }


    // MARK: handle user approval
    
    func approveUserSelected() {
        if let authenticateObject = authObject, let userId = selectedUser?.id {
            approveUser(userId: userId, authObject: authenticateObject)
        }
    }
    
    func denyUserSelected() {
        if let authenticateObject = authObject, let userId = selectedUser?.id {
            denyUser(userId: userId, authObject: authenticateObject)
        }
    }
}
