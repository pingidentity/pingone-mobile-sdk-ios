//
//  HomeViewController.swift
//  SampleApp
//
//  Created by Ping Identity on 10/10/19.
//  Copyright © 2019 Ping Identity. All rights reserved.
//

import UIKit
import PingOneSDK

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var actionTableView: UITableView!
    var actionsArray = [ActionItem]()
    var notificationObject: NotificationObject?
    
    @IBOutlet weak var versionOutlt: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let pairAction = ActionItem.init(actionName: PairingMethodName.Manual, segueID: SegueName.Manual, actionType: .segue)
        let oidcAction = ActionItem.init(actionName: PairingMethodName.OIDC, segueID: SegueName.OIDC, actionType: .segue)
        let authnAction = ActionItem.init(actionName: AuthnAPIName.authnAPI, segueID: SegueName.authnAPI, actionType: .segue)
        let PasscodeAction = ActionItem.init(actionName: SDKFunctionality.OneTimePasscode, segueID: SegueName.passcode, actionType: .segue)
        let QRAuthAction = ActionItem.init(actionName: SDKFunctionality.QRAuth, segueID: SegueName.QRAuth, actionType: .segue)
        let logsAction = ActionItem.init(actionName: SDKFunctionality.SendLogs, segueID: nil, actionType: .sendLogs)
        actionsArray = [pairAction, oidcAction, authnAction, logsAction, PasscodeAction, QRAuthAction]
        self.navigationItem.title = Local.appTitle
        if let version = getAppVersionAndBuild() {
            versionOutlt.text = version
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateScreenByClientContext), name: NSNotification.Name(rawValue: "notificationRecived"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resetClientContextUpdate), name: NSNotification.Name(rawValue: "notificationResponded"), object: nil)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "notificationRecived"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "notificationResponded"), object: nil)
    }

    func getAppVersionAndBuild() -> String? {
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            if let appBuild = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
                return "v\(appVersion)(\(appBuild))"
            }
        }
        return nil
    }
    
    @objc func updateScreenByClientContext() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Error accessing AppDelegate")
            return
        }
        
        self.notificationObject = appDelegate.notificationObject
        
        if let jsonStr = self.notificationObject?.clientContext {

            var clientContextJson = [String: Any]()
            if let data = jsonStr.data(using: .utf8) {
                do {
                    clientContextJson = try (JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] ?? [:])
                } catch {
                    print(error.localizedDescription)
                }
            }
                
            if let fontStr = clientContextJson["header_font_color"] as? String {
                let attributes = [NSAttributedString.Key.foregroundColor: UIColor(hexString: fontStr)]
                self.navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key: Any]
            }
        }
    }
    
    @objc func resetClientContextUpdate() {
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key: Any]
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    // TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actionsArray.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell")
 
        if actionsArray.count > 0 {
            cell?.textLabel!.text = actionsArray[indexPath.row].actionName
        }
        cell?.textLabel?.numberOfLines = 0

        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedActionItem = actionsArray[indexPath.row]
        
        switch selectedActionItem.type {
        case .segue:
            if let segueID = selectedActionItem.segueID {
              self.performSegue(withIdentifier: segueID, sender: nil)
            }
        case .sendLogs:
            PingOne.sendLogs { (supportId, error) in
                if let supportId = supportId {
                    Alert.generic(viewController: self, message: "Support ID: \(supportId)", error: nil)
                    print("Support ID:\(supportId)")
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }  
}
