//
//  AuthenticationVC.swift
//  iOSAuthenticator_Example
//
//  Created by Luigi Aiello on 19/04/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import iOSAuthenticator

class AuthenticationVC: UIViewController {
    
    //MARK:- Outlets
        //MARK:- Views
    @IBOutlet weak var firstAuthstackView: UIStackView!
    @IBOutlet weak var secondAuthStackView: UIStackView!
    
    //MARK:- Buttons
    @IBOutlet weak var firstAuthButton: RoundedOutlineButton!
    @IBOutlet weak var secondAuthButton: RoundedOutlineButton!
    
        //MARK:- Labels
    @IBOutlet weak var firstAuthDescriptionLabel: UILabel!
    @IBOutlet weak var secondAuthDescriptionLabel: UILabel!
    
        //MARK:- ImageView
    @IBOutlet weak var firstAuthImageView: UIImageView!
    @IBOutlet weak var secondAuthImageView: UIImageView!
    
    //MARK:- Override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurationUI()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- Setup
    private func configurationUI() {
        // Use biometric type to configure UI
        switch iOSAuthenticator.biometricType() {
        case .touchID:
            setTouchIDUI()
        case .faceID:
            setFaceIDUI()
        case .notAvailable:
            //Show Alert or do something
            print("Not available")
        }
    }
    
    //MARK:- Graphics Helpers
    private func setTouchIDUI() {
        firstAuthImageView.image = #imageLiteral(resourceName: "ic_touchID1")
        firstAuthButton.setTitle("Use Touch ID", for: .normal)
        firstAuthDescriptionLabel.text = "Use Touch ID with default passcode"
        
        secondAuthImageView.image = #imageLiteral(resourceName: "ic_touchID2")
        secondAuthButton.setTitle("Use Touch ID", for: .normal)
        secondAuthDescriptionLabel.text = "Use Touch ID with default passcode"
    }
    private func setFaceIDUI() {
        let firstFaceTinted = #imageLiteral(resourceName: "ic_faceID").tinted(with: UIColor(hex: 0xAC222A))
        firstAuthImageView.image = firstFaceTinted
        firstAuthButton.setTitle("Use Face ID", for: .normal)
        firstAuthDescriptionLabel.text = "Use Face ID with default passcode"
        
        let secondFaceTinted = #imageLiteral(resourceName: "ic_faceID").tinted(with: UIColor(hex: 0xAC22D6))
        secondAuthImageView.image = secondFaceTinted
        secondAuthButton.setTitle("Use Face ID", for: .normal)
        secondAuthDescriptionLabel.text = "Use Face ID with custom fallback"
    }
    
    //MARK:- Helpers
    private func navigateToLoggedInVC() {
        guard
            let storyboard = self.storyboard,
            let vc = storyboard.instantiateViewController(withIdentifier: "LoggedInVC") as? LoggedInVC
        else {
            print("I can go to next storyboard")
            return
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    private func navigateToFallbackVC() {
        guard
            let storyboard = self.storyboard,
            let vc = storyboard.instantiateViewController(withIdentifier: "FallbackVC") as? FallbackVC
        else {
            print("I can go to next storyboard")
            return
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK:- Actions
    @IBAction func firstButtonDidTap(_ sender: Any) {
        iOSAuthenticator.authenticateWithBiometricsAndPasscode(reason: "Please help me to protect your data", success: {
            print("Success")
            self.navigateToLoggedInVC()
        }) { (error) in
            print("Error")
        }
    }
    @IBAction func secondButtonDidTap(_ sender: Any) {
        iOSAuthenticator.authenticateWithBiometricsAndFallback(reason: "Please help me to protect your data", fallbackTitle: nil, cancelTitle: "cancella", fallback: {
            print("Fallback")
            self.navigateToFallbackVC()
        }, success: {
            self.navigateToLoggedInVC()
            print("Success")
        }) { (error) in
            print("Error \(error)")
        }
    }
}
