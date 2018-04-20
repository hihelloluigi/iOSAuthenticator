//
//  RoundedOutlineView.swift
//  BiometricAuth
//
//  Created by Luigi Aiello on 18/04/18.
//  Copyright © 2018 Luigi Aiello. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedOutlineButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            setupView()
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            setupView()
        }
    }
    @IBInspectable var borderColor: UIColor? {
        didSet {
            setupView()
        }
    }
    
    private func setupView() {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor?.cgColor
    }
    
    override func prepareForInterfaceBuilder() {
        setupView()
    }
}
