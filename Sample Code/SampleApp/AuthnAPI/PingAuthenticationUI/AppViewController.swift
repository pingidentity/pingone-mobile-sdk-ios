//
//  AppViewController.swift
//  AuthnAPI
//
//  Copyright © 2020 Ping Identity. All rights reserved.
//
//  See LICENSE.txt for the Ping Authentication licensing information.
//

import UIKit

class AppViewController: UIViewController {

    private var spinner = UIActivityIndicatorView()
    private var keyboardHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSpinner()
    }
    

    // MARK: loading spinner methods
    
    func initSpinner() {
        DispatchQueue.main.async {
            if #available(iOS 13.0, *) {
                self.spinner.style = .medium
            } else {
                self.spinner.style = .gray
            }
            
            self.spinner.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(self.spinner)

            if #available(iOS 9.0, *) {
                self.spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
                self.spinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
            } else {
                self.spinner.translatesAutoresizingMaskIntoConstraints = true
                self.spinner.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
            }
        }
    }
    
    func startLoadingAnimation() {
        DispatchQueue.main.async {
            self.spinner.startAnimating()
            self.spinner.isHidden = false
        }
    }
    
    func stopLoadingAnimation() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
        }
    }
    
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
