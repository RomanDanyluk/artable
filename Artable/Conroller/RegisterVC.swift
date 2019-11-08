//
//  RegisterVC.swift
//  Artable
//
//  Created by Romaha  on 11/8/19.
//  Copyright © 2019 Romaha . All rights reserved.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confirmPassTxt: UITextField!
    @IBOutlet weak var activivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var passCheckImg: UIImageView!
    @IBOutlet weak var confirmPassCheckImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        confirmPassTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        // Do any additional setup after loading the view.
    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let passTxt = passwordTxt.text else { return }
        
        if textField == confirmPassTxt {
            passCheckImg.isHidden = false
            confirmPassCheckImg.isHidden = false
        } else {
            if passTxt.isEmpty {
                passCheckImg.isHidden = true
                confirmPassCheckImg.isHidden = true
                confirmPassTxt.text = ""
            }
        }
        
        if passwordTxt.text == confirmPassTxt.text {
            passCheckImg.image = UIImage(named: AppImg.GreenCheck)
            confirmPassCheckImg.image = UIImage(named: AppImg.GreenCheck )
        } else {
            passCheckImg.image = UIImage(named: AppImg.RedCheck)
            confirmPassCheckImg.image = UIImage(named: AppImg.RedCheck)
        }
    }
   
    
    @IBAction func registerClicked(_ sender: Any) {
        guard let email = emailTxt.text, email.isNotEmpty,
              let username = userNameTxt.text, username.isNotEmpty,
              let password = passwordTxt.text, password.isNotEmpty else { return }
        
        activivityIndicator.startAnimating()
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                debugPrint(error)
                return
            }
            
            self.activivityIndicator.startAnimating()
            print("all ok with succes")
        }
        
    }
    

}
