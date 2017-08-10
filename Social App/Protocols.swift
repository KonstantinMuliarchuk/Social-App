//
//  ViewProtocol.swift
//  Social App
//
//  Created by Мулярчук Константин on 09.08.17.
//  Copyright © 2017 healthAndFitnes. All rights reserved.
//

import UIKit

protocol CustomButtonProtocol {}

extension CustomButtonProtocol where Self: UIButton {
    
    func configureFace() {
        
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize.zero
        layer.shadowColor = UIColor.black.cgColor
        layer.cornerRadius = frame.width / 2
        layer.shadowOpacity = 0.6
    }
    func configureLogin() {
        
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize.zero
        layer.shadowColor = UIColor.black.cgColor
        layer.cornerRadius = 2.0
        layer.shadowOpacity = 0.6
    }
}

protocol CustomViewProtocol {}

extension CustomViewProtocol where Self: UIView {
    
    func configure() {
        
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize.zero
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.6
        layer.cornerRadius = 2.0
    }
}

protocol CustomTextFieldProtocol {}

extension CustomTextFieldProtocol where Self: UITextField {
    
    func configure() {
        layer.borderColor = UIColor(red: SHADOW_GREY, green: SHADOW_GREY, blue: SHADOW_GREY, alpha: 0.2).cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 2.0
    }
}

protocol CustomImageProtocol {}

extension CustomImageProtocol where Self: UIImageView {
    
    func configure() {
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize.zero
        layer.shadowColor = UIColor.black.cgColor
        layer.cornerRadius = frame.width / 2
        layer.shadowOpacity = 0.6
    }
}
