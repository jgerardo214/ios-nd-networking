//
//  LoginViewController.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginViaWebsiteButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        TMDBClient.getRequestToken(completion: handleRequestTokenReponse(success:error:))
    }
    
    @IBAction func loginViaWebsiteTapped() {
        performSegue(withIdentifier: "completeLogin", sender: nil)
    }
    
    func handleRequestTokenReponse(success: Bool, error: Error?) {
        if success {
            print(TMDBClient.Auth.requestToken)
            DispatchQueue.main.async {
                TMDBClient.login(username: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "", completion: self.handleRequestTokenReponse(success:error:))
            }
            
        }
        
        func handleLoginResponse(success: Bool, error: Error?) {
            print(TMDBClient.Auth.requestToken)
            
            if success {
                TMDBClient.createSessionID(completion: handleLoginResponse(success:error:))
            }
        }
    }
    
    func handleSessionReponse(success: Bool, error: Error?) {
        
        if success {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "completeLogin", sender: nil)
            }
            
            
        }
        
    }
    
}
