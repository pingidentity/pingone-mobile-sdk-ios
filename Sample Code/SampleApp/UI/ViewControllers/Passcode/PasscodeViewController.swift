//
//  PasscodeViewController.swift
//  SampleApp
//
//  Copyright © 2021 Ping Identity. All rights reserved.
//

import UIKit
import PingOneSDK

class PasscodeViewController: UIViewController {

    @IBOutlet weak var passCodeLbl: UILabel!
    @IBOutlet weak var timerLbl: UILabel!
    
    var oneTimePasscodeData: OneTimePasscodeInfo?
    var passcodeTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = SDKFunctionality.OneTimePasscode
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getOneTimePasscode()
    }
    
    // MARK: - OTP functions
    
    func getOneTimePasscode() {
        PingOne.getOneTimePasscode() {[weak self] oneTimePasscodeData, error in
            guard let self = self else {
                return
            }
            
            if let _ = oneTimePasscodeData?.passcode {
                self.oneTimePasscodeData = oneTimePasscodeData
                self.initializePasscodeLabel()
                return
            }
            
            guard let _ = error else {
                return
            }
            DispatchQueue.main.async {
                self.passCodeLbl.text =  OneTimePasscodeError.notPaired
                self.timerLbl.text = ""
            }
        }
    }
    
    func initializePasscodeLabel() {
        passcodeTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updatePasscodeTime), userInfo: nil, repeats: true)
    }
    
    @objc func updatePasscodeTime() {
        let date = Date()
        
        guard let passcodeData = self.oneTimePasscodeData else {
            return
        }
        guard isPasscodeEnded(currentdate: date, eventdate: Date(timeIntervalSince1970: passcodeData.validUntil)) == false else {
            resetOneTimePasscode()
            getOneTimePasscode()
            return
        }
        
        let remainTime = Int(passcodeData.validUntil - Date().timeIntervalSince1970)
        
        passCodeLbl.text = "\(passcodeData.passcode)"
        timerLbl.text = "\(remainTime)s"
    }
    
    func isPasscodeEnded(currentdate: Date, eventdate: Date) -> Bool {
        if currentdate >= eventdate {
            return true
        }
        return false
    }
    
    func resetOneTimePasscode() {
        passCodeLbl.text = ""
        timerLbl.text = ""
        
        passcodeTimer?.invalidate()
        passcodeTimer = nil
        oneTimePasscodeData = nil
    }
}
