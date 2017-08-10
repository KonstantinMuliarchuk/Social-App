//
//  FeedVC.swift
//  Social App
//
//  Created by Мулярчук Константин on 10.08.17.
//  Copyright © 2017 healthAndFitnes. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController {
    @IBOutlet weak var navigationView: CustomView!
    @IBOutlet weak var postButton: CustomButton!
    @IBOutlet weak var chouseImage: CustomImmageView!
    @IBOutlet weak var descrTextField: CustomTextField!
    @IBOutlet weak var profileImage: CustomImmageView!

    @IBOutlet weak var logoutBtn: CustomButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationView.configure()
        postButton.configureFace()
        chouseImage.configure()
        descrTextField.configure()
        
        

    }

    @IBAction func logoutButtton(_ sender: Any) {
        performSegue(withIdentifier: "GoBackToLogin", sender: nil)
        let keyChainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("Kot: Logjut and delete key from Keychain \(keyChainResult)")
        try! Auth.auth().signOut()
        
        
    }

}
