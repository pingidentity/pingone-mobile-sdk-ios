//
//  MainUIViewController.swift
//  AuthnAPI
//
//  Copyright © 2020 Ping Identity. All rights reserved.
//
//  See LICENSE.txt for the Ping Authentication licensing information.
//

import UIKit

class MainAuthViewController: AppViewController, UITextFieldDelegate {

    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var screenTitleLbl: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signOnBtn: UIButton!
    @IBOutlet weak var versionLbl: UILabel!
    
    var alertHandler: AlertHandler?
    var completion: ((String, String, NSError?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        alertHandler = AlertHandler(presenter: self)
        
        setViews()
    }
    
    private func setViews() {
        hideLoginUI(true)
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        screenTitleLbl.text = Identifiers.loginTitle
        versionLbl.text = Identifiers.versionName
        
        if let actions = authenticationState.actions {
            self.showActions(actions) { (response, error) in
                if let authError = error {
                    self.showError(authError) {
                        self.dismissVC()
                    }
                }
            }
        }
        
    }
    
    @IBAction func closeWasTapped(_ sender: Any) {
        self.dismissVC()
    }
    
    @IBAction func submitBtnWasTapped(_ sender: Any) {
    
        passwordTextField.resignFirstResponder()
        guard let status = authenticationState.status else {
            return
        }
    
        switch status {
        case .usernamePasswordRequired:
            
            if let username = usernameTextField.text, let password = passwordTextField.text {
                requestParams.userName = username
                requestParams.password = password
                hideLoginUI(true)
                authenticateUser(with: requestParams)
            }
            
        case .otpRequired:
            
            if let otp = passwordTextField.text {
                requestParams.otp = otp
                hideOTP()
                authenticateUser(with: requestParams)
            }
            
        default:
            // Retrying login or otp
            
            if let username = usernameTextField.text, let password = passwordTextField.text, let otp = passwordTextField.text {
                
                requestParams.userName = username
                requestParams.password = password
                requestParams.otp = otp
                hideLoginUI(true)
                hideOTP()
                authenticateUser(with: requestParams)
            }
        }
    }
    
    // MARK: authenticate
    
    private func authenticateUser(with params: RequestParams) {
        
        sharedUILogicLayer.needToPresentVC = false
        self.startLoadingAnimation()
        
        sharedUILogicLayer.authenticate(request: requestParams) { [weak self] (response, error) in

            guard let self = self else {
                return
            }
            
            self.stopLoadingAnimation()
            
            if let error = error, response == nil {
                if authenticationState.error == .validationError { // Only validation error keep the UI of authenAPI
                    self.alertHandler?.showOKAlert(title: Identifiers.errorTitle, message: error.userInfo.description)
                    
                    if requestParams.name == Identifiers.PathNameLogin {
                        self.hideLoginUI(false)
                    } else if requestParams.name == Identifiers.PathNameOTP {
                        self.showOTP()
                    }
                } else { // Other errors close the authenAPI UI
                    self.closeAuthUI(response: response)
                }
            }
            
            if let authResponse = response {
   
                if authenticationState.status == .usernamePasswordRequired {
                    self.hideLoginUI(false)
                } else if authenticationState.status == .otpRequired {
                    self.showOTP()
                }
                
                if let actions = authResponse.actions {
                    self.showActions(actions) { (response, error) in
                        
                        // In case pairing is needed, close authnAPI and open hosting app to complete pairing
                        
                        if response?.status == .mobileParingRequired {
                            DispatchQueue.main.async {
                                self.stopLoadingAnimation()
                                
                                if let completion = authenticationState.authCompletion, let serverPayload = authenticationState.serverPayload {
                                    
                                    self.alertHandler?.showOKAlertWithCompletion(title: authenticationState.status?.rawValue, message: nil) {
                                        
                                        authenticationState.status = .mobileParingStarted
                                        completion(serverPayload, "", error as NSError?)
                                        self.dismiss(animated: true)
                                    }
                                }
                            }
                        } else if response?.status == .failed  || response?.status == .completed {
                            self.closeAuthUI(response: response)
                        }
                    }
                }
            }
            
        }
        self.stopLoadingAnimation()
    }
    
    // MARK: handle UI change
    
    private func hideLoginUI(_ isShowing: Bool) {
        DispatchQueue.main.async {
            
            self.passwordTextField.resignFirstResponder()
            
            self.screenTitleLbl.isHidden = isShowing
            self.usernameTextField.isHidden = isShowing
            self.passwordTextField.isHidden = isShowing
            self.passwordTextField.isSecureTextEntry = true
            self.signOnBtn.setTitle(Identifiers.signOnBtnText, for: .normal)
            self.signOnBtn.isHidden = isShowing
            if isShowing {
                self.startLoadingAnimation()
            } else {
                self.stopLoadingAnimation()
            }
        }
    }
    
    private func showOTP() {
        DispatchQueue.main.async {
            
            self.passwordTextField.resignFirstResponder()
            
            self.stopLoadingAnimation()
            self.passwordTextField.text = ""
            self.passwordTextField.placeholder = Identifiers.otpPlaceholder
            self.passwordTextField.keyboardType = .numberPad
            self.passwordTextField.isSecureTextEntry = false
            self.signOnBtn.setTitle(Identifiers.otpSubmitBtnText, for: .normal)
            
            self.screenTitleLbl.isHidden = true
            self.usernameTextField.isHidden = true
            self.passwordTextField.isHidden = false
            self.signOnBtn.isHidden = false
        }
    }
    
    private func hideOTP() {
        DispatchQueue.main.async {
            self.startLoadingAnimation()
            self.screenTitleLbl.isHidden = true
            self.usernameTextField.isHidden = true
            self.passwordTextField.isHidden = true
            self.passwordTextField.isSecureTextEntry = true
            self.signOnBtn.isHidden = true
            
            self.passwordTextField.placeholder = Identifiers.passwordFieldPlaceholder
            self.passwordTextField.keyboardType = .default
            self.signOnBtn.setTitle(Identifiers.signOnBtnText, for: .normal)
        }
    }
    
    // MARK: handle auth actions
    
    private func showActions(_ actions: [AuthAction], completionHandler: @escaping (_ response: AuthenticationState?, _ error: Error?) -> Void) {
        
        if authenticationState.actions?.count == 0 || authenticationState.status == .mobileParingRequired {
            completionHandler(authenticationState, nil)
        } else {
            
            guard let actionsStringArray = alertHandler?.getStringActions(from: actions) else {
                return
            }
            alertHandler?.showAlertWithOptions(title: authenticationState.status?.rawValue, message: nil, options: actionsStringArray) { (pickedActionString, index)  in
                self.stopLoadingAnimation()
                
                let pickedAction = AuthAction.init(rawValue: pickedActionString)
                requestParams.action = pickedAction

                if pickedAction == .checkUsernamePassword {
                    self.hideLoginUI(false)
                    completionHandler(authenticationState, nil)
                    return
                } else if pickedAction == .checkOtp {
                    self.showOTP()
                    completionHandler(authenticationState, nil)
                    return
                } else if pickedAction == .deviceSelectionRequired {
                    if let devicesNamesDict = authenticationState.devicesNames {
                        self.selectDevice(devicesNamesDict: devicesNamesDict) { deviceId in
                            
                            requestParams.deviceId = deviceId
                            self.setAuthAction(pickedAction, completion: completionHandler)
                        }
                    }
                }
                self.setAuthAction(pickedAction, completion: completionHandler)
            }
        }
    }
    
    private func setAuthAction(_ action: AuthAction?, completion: @escaping (_ response: AuthenticationState?, _ error: NSError?) -> Void) {
        
        startLoadingAnimation()
        requestParams.action = action
        sharedUILogicLayer.needToPresentVC = false
        
        sharedUILogicLayer.authenticate(request: requestParams) { [weak self] response, error in
            
            guard let self = self else {
                return
            }
            
            self.stopLoadingAnimation()
            
            if let authError = error {
                self.showError(authError) {
                    completion(response, nil)
                }
            } else {
                if let response = response {
                    if let actions = response.actions {
                        if response.status == .mobileParingRequired {
                            completion(response, nil)
                        }
                        if response.status == .completed || response.status == .failed || response.status == .tokenExchangeCompleted {
                            self.closeAuthUI(response: response)
                            completion(response, nil)
                        } else {
                            self.showActions(actions) { (response, error) in
                                if let authError = error {
                                    self.showError(authError) {
                                        completion(response, nil)
                                    }
                                }
                            }
                        }
                    } else {
                        self.closeAuthUI(response: response)
                        completion(response, nil)
                    }
                }
            }
        }
    }
    
    private func selectDevice(devicesNamesDict: [String: String], completion: @escaping (_ devicePickedId: String) -> Void) {
        DispatchQueue.main.async {
            self.stopLoadingAnimation()
            let deviceNameArr = Array(devicesNamesDict.values) as [String]
            let deviceIdsArr = Array(devicesNamesDict.keys) as [String]

            self.alertHandler?.showAlertWithOptions(title: authenticationState.status?.rawValue, message: nil, options: deviceNameArr) { pickedDeviceId, index  in
                
                let pickedId = deviceIdsArr[index]
                print("pickedDeviceId = \(pickedId)")
                completion(pickedId)
            }
        }
    }

    // MARK: handle UI cycle
    
    private func closeAuthUI(response: AuthenticationState?) {
        DispatchQueue.main.async {
            self.stopLoadingAnimation()
            
            if authenticationState.authCompletion != nil {
                if response?.status == .errorReceived {
                    self.dismissVC()
                } else {
                    var errorCode: String?
                    if response?.status == .failed {
                        errorCode = response?.code ?? ""
                    }
                    self.alertHandler?.showOKAlertWithCompletion(title: response?.status?.rawValue, message: errorCode) {
                        self.dismissVC()
                    }
                }
            }
        }
    }
    
    private func dismissVC() {
        initAPI()
        
        if let completion = authenticationState.authCompletion {
            completion("", authenticationState.accessToken ?? "", nil)
        }
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }
    
    private func initAPI() {
        requestParams.flowId = nil
        requestParams.action = nil
        authenticationState.flowId = nil
        sharedUILogicLayer.needToPresentVC = true
    }
    
    // MARK: handle errors
    
    private func showError(_ error: Error, completion: @escaping () -> Void) {
        alertHandler?.showOKAlertWithCompletion(title: nil, message: error.localizedDescription) {
            self.stopLoadingAnimation()
            self.closeAuthUI(response: authenticationState)
            completion()
        }
    }

}
