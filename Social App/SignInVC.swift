//
//  ViewController.swift
//  Social App
//
//  Created by Мулярчук Константин on 09.08.17.
//  Copyright © 2017 healthAndFitnes. All rights reserved.
//

import UIKit

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


}

