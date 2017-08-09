//
//  CustomTextField.swift
//  Social App
//
//  Created by Мулярчук Константин on 09.08.17.
//  Copyright © 2017 healthAndFitnes. All rights reserved.
//

import UIKit

class CustomTextField: UITextField, CustomTextFieldProtocol {

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5)
    }


}
