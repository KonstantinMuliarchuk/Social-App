//
//  ViewController.swift
//  Social App
//
//  Created by Мулярчук Константин on 09.08.17.
//  Copyright © 2017 healthAndFitnes. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase
import SwiftKeychainWrapper


class SignInVC: UIViewController {

    
    @IBOutlet weak var passText: CustomTextField!
    @IBOutlet weak var emailText: CustomTextField!
    @IBOutlet weak var loginBtn: CustomButton!
    @IBOutlet weak var faceBtn: CustomButton!
    @IBOutlet weak var mainView: CustomView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        
        self.loginBtn.configureLogin()
        self.faceBtn.configureFace()
        self.mainView.configure()
        self.passText.configure()
        self.emailText.configure()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
    }
    
    @IBAction func facebookBtnPressed(_ sender: CustomButton) {
        
        let facebookManager = FBSDKLoginManager()
        
        facebookManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("KOT: you have troble with login \(String(describing: error))")
            } else if result?.isCancelled == true {
                print("KOT: user canceled Facebook Aut")
            }else {
                print("KOT: you are IN Facebook")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAut(credential)
           
            }
        }
        
        
    }
    func firebaseAut(_ credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { (user, error) in
            
                if error != nil {
                    print("KOt: enebled to autentification to Firebase")
                } else {
                    print("Kot: We are in Firebase")
                    if let user = user {
                        let userData = ["provider": credential.provider]
                        self.completeSignIn(id: user.uid, userData: userData)
                        
                    }
                }
            }
        }
    
    @IBAction func signInButtonPressed(_ sender: CustomButton) {
        
        if let email = emailText.text, let password = passText.text {
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    print("Kot: We are login to Firebase via Email")
                    if let user = user {
                        let userData = ["provider": user.providerID]
                        self.completeSignIn(id: user.uid, userData: userData)
                    }
                        } else {
                            Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                                if error != nil {
                                    print("Kot: Enable to create account in Firebase via email ")
                                }else {
                                    print("Kot: we are create account and log in to Firebase via email ")
                                    if let user = user {
                                        let userData = ["provider": user.providerID]
                                        self.completeSignIn(id: user.uid, userData: userData)
                                    }
                                }
                            })
                }
            })
        }
        
        
    }
    func completeSignIn (id: String, userData: Dictionary<String, String>) {
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        let keyChainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("Kot: Data saved to keychain = \(keyChainResult)")
        performSegue(withIdentifier: "goToFeed", sender: nil)
    }


}

