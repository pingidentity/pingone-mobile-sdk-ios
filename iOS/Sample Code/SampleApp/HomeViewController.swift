//
//  HomeViewController.swift
//  SampleApp
//
//  Created by Ping Identity on 10/10/19.
//  Copyright © 2019 Ping Identity. All rights reserved.
//

import UIKit
import PingOne
class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var actionTableView: UITableView!
    var actionsArray: Array<ActionItem>!
    
    @IBOutlet weak var versionOutlt: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let pairAction = ActionItem.init(actionName: PairingMethodName.Manual, segueID: SegueName.Manual)
        let oidcAction = ActionItem.init(actionName: PairingMethodName.OIDC, segueID: SegueName.OIDC)
        actionsArray = [pairAction,oidcAction]
        self.navigationItem.title = "Sample"
        if let version = getAppVersionAndBuild() {
            versionOutlt.text = version
        }
    }

    func getAppVersionAndBuild() -> String?{
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            if let appBuild = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
                return "v\(appVersion)(\(appBuild))"
            }
        }
        return nil
    }
    
    //Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return actionsArray.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    var cell : UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        }
        if self.actionsArray.count > 0 {
            cell?.textLabel!.text = self.actionsArray[indexPath.row].actionName
        }
        cell?.textLabel?.numberOfLines = 0

        return cell!
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let selectedActionItem = actionsArray[indexPath.row]
        self.performSegue(withIdentifier: selectedActionItem.segueID, sender: nil)
    }
}
