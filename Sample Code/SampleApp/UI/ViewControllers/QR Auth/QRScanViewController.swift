//
//  QRScanViewController.swift
//  SampleApp
//
//  Created by Ping Identity on 11/11/2021.
//  Copyright © 2021 Ping Identity. All rights reserved.
//

import UIKit
import AVFoundation
import PingOneSDK

class QRScanViewController: MainViewController, UITextFieldDelegate, QRCaptureDelegate {

    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var authKeyTextField: UITextField!
    private var capture: QRCapture?
    
    var isKeyboardVisible = false
    var viewOriginY: CGFloat = 0
    var keyboardHeightFactor: CGFloat = 0.75
    var authObject: AuthenticationObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        capture = QRCapture()
        capture?.delegate = self
        self.cameraView.clipsToBounds = true
        
        addKeyboardNotifications()
    }
    
    // MARK: Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Handle camera UI
        cameraView.alpha = 0
        cameraView.clipsToBounds = true

        // Handle permissions
        DispatchQueue.main.async {
            if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) != .authorized {
                AVCaptureDevice.requestAccess(for: AVMediaType.video) { granted in
                    DispatchQueue.main.async {
                        self.cameraView.alpha = 1
                        self.startCameraPreview()
                    }
                }
            } else {
                self.startCameraPreview()
            }
        }
    }
    
    @IBAction func authenticateWasTapped(_ sender: Any) {
        startLoadingAnimation()
        if let code = self.authKeyTextField.text {
            authenticateWith(code)
        } else {
            print("No code was entered")
        }
    }
    
    func startCameraPreview() {
        capture?.addPreviewLayerTo(self.cameraView, withDelay: false) { (isDone) in
            if isDone {
                UIView.animate(withDuration: 0.25) {
                    self.cameraView.alpha = 1
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.capture?.stop()
    }
    
    deinit {
        removeKeyboardNotifications()
    }
    
    // MARK: QRCameraDelegate
    
    func found(code: String) {
        startLoadingAnimation()
        print("found code: \(code)")
        
        DispatchQueue.main.async {
            self.authKeyTextField.text = code
        }
        authenticateWith(code)
    }
    
    func failed(error: String) {
        print(error)
    }
    
    func openUsersApprovalVC() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            self.performSegue(withIdentifier: SegueName.UserApproval, sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueName.UserApproval {
            if let userVC = segue.destination as? UserApprovalViewController {
                userVC.authObject = self.authObject
            }
        }
    }
    
    // MARK: PingOneSDK methods call
    
    func authenticateWith(_ code: String) {
        PingOne.authenticate(code) { obj, error in
            self.stopLoadingAnimation()
            self.handleAuthObject(obj, error)
        }
    }
    
    func handleAuthObject(_ obj: AuthenticationObject?, _ error: Error?) {
        
        if error != nil { // If any error
            Alert.genericWithDismiss(viewController: self, title: nil, message: nil, error: error as NSError?) {
                self.view.endEditing(true)
                self.dismissToRoot()
            }
        }
        
        guard let authObject = obj, let status = authObject.status else {
            print("No Authenticate Object.")
            return
        }
        
        self.authObject = authObject
        
        switch status {
        case Local.AuthStatusExpired: // EXPIRED, user can retry scan a new code
            Alert.generic(viewController: self, title: Local.Error, message: status, error: nil)
            self.startCameraPreview()
        
        case Local.AuthStatusCompleted: // COMPLETED status means that auth flow is done. In this case show the status and dismiss the controller
            Alert.genericApproveWithDismiss(viewController: self, title: Local.Success, message: status, error: nil) {
                self.dismissToRoot()
            }
        
        case Local.AuthStatusClaimed: // CLAIMED status means flow is not completed yet
            guard let users = authObject.users else {
                print("No Users.")
                return
            }
            
            let usersArray = UsersHandler().createUsersArray(users)
            if usersArray.count == 1, let userId = usersArray.first?.id { // If No need for user selection
                self.approveAuth(userId: userId, authObject: authObject) // Approve or Deny for ONE user
                
            } else if usersArray.count > 1 { // Need user selection for approval
                self.openUsersApprovalVC()
            } 
            
        default:
            print("status \(status) is not handled.")
        }
    }
    
    func approveAuth(userId: String, authObject: AuthenticationObject) {
        let title = "\(Local.UserSelectionTitle) \(userId)"
        
        Alert.approveDeny(viewController: self, title: title, message: nil) { approved in
            if let approvedResult = approved {
                if approvedResult {
                    self.approveUser(userId: userId, authObject: authObject)
                } else {
                    self.denyUser(userId: userId, authObject: authObject)
                }
            } else { // CANCEL
                self.dismissToRoot()
            }
        }
    }
    
    // MARK: Handle Keyboard Raise
    
    func addKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let factor = keyboardHeightFactor
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.view.frame.origin.y -= keyboardSize.height * factor
        }

        isKeyboardVisible = true
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = -15
        isKeyboardVisible = false
    }

    // MARK: TextField Delegates
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        authKeyTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        return true
    }

}
