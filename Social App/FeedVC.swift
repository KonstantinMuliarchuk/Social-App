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

    @IBOutlet weak var logoutBtn: CustomButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoutBtn.configureLogin()

    }

    @IBAction func logoutButtton(_ sender: Any) {
        performSegue(withIdentifier: "GoBackToLogin", sender: nil)
        let keyChainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("Kot: Logjut and delete key from Keychain \(keyChainResult)")
        try! Auth.auth().signOut()
        
        
    }

}
