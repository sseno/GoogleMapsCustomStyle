//
//  SignInViewController.swift
//  GoogleMapsCustomStyle
//
//  Created by Rohmat Suseno on 22/01/20.
//  Copyright © 2020 Rohmts. All rights reserved.
//

import UIKit
import LBTATools

class SignInViewController: LBTAFormController {
    
    let img = UIImageView(image: UIImage(named: "signin_image"))
    
    let emailLabel = UILabel(text: "Email",
                             font: .systemFont(ofSize: 16),
                             textColor: .gray)
    let passwordLabel = UILabel(text: "Password",
                                font: .systemFont(ofSize: 16),
                                textColor: .gray)
    let signInButton = UIButton(title: "Sign In",
                                titleColor: .white,
                                font: .systemFont(ofSize: 16),
                                backgroundColor: #colorLiteral(red: 0.4274509804, green: 0.3843137255, blue: 0.9882352941, alpha: 1),
                                target: self,
                                action: #selector(handleSignIn))
    let forgotPswdLabel = UILabel(text: "Forgot Password?",
                                  font: .systemFont(ofSize: 14),
                                  textColor: .gray,
                                  textAlignment: .right)
    let signUpLabel = UILabel(text: "Don't have an account? Create here",
                              font: .systemFont(ofSize: 16),
                              textColor: .black,
                              textAlignment: .center)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
        setupForm()
        setupTextField()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setupForm() {
        formContainerStackView.axis = .vertical
        formContainerStackView.spacing = 15
        formContainerStackView.layoutMargins = .init(top: 15, left: 0, bottom: 15, right: 0)
        
        let sv = UIStackView(arrangedSubviews: [img, UIView()])
        sv.axis = .vertical
        
        formContainerStackView.addArrangedSubview(sv)
    }
    
    private func setupTextField() {
        for i in 0...1 {
            switch i {
            case 0:
                setupTextField(placeholder: "Enter your email", keyboardType: .emailAddress)
            case 1:
                setupTextField(placeholder: "Enter your password", keyboardType: .default, isSecureText: true)
            default:
                break
            }
        }
        
        signInButton.constrainHeight(50)
        signInButton.layer.cornerRadius = 10
        
        let buttonStack = UIStackView(arrangedSubviews: [signInButton, forgotPswdLabel, UIView().withHeight(30), signUpLabel, UIView().withHeight(30)])
        buttonStack.axis = .vertical
        buttonStack.spacing = 15
        formContainerStackView.addArrangedSubview(
            buttonStack.padTop(30).padLeft(30).padRight(30))
    }
    
    private func setupTextField(placeholder: String, keyboardType: UIKeyboardType, isSecureText: Bool = false) {
        let tf = IndentedTextField(placeholder: placeholder, padding: 15, cornerRadius: 10, keyboardType: keyboardType, backgroundColor: .white, isSecureTextEntry: isSecureText)
        tf.constrainHeight(50)
        
        let sv = UIStackView(arrangedSubviews: [isSecureText ? passwordLabel : emailLabel,tf])
        sv.axis = .vertical
        sv.spacing = 12
        
        formContainerStackView.addArrangedSubview(sv.padLeft(30).padRight(30))
    }
    
    @objc func handleSignIn() {
        self.navigationController?.pushViewController(MainViewController(), animated: true)
    }
}

#if DEBUG
import SwiftUI
struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice(.init(stringLiteral: "iPhone 6s"))
            .edgesIgnoringSafeArea(.all)
    }
    
    struct ContentView: UIViewControllerRepresentable {
        func makeUIViewController(context: UIViewControllerRepresentableContext<SignIn_Previews.ContentView>) -> UIViewController {
            return UINavigationController(rootViewController: SignInViewController())
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<SignIn_Previews.ContentView>) {
        }
    }
}
#endif
