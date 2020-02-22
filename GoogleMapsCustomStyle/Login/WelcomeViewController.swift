//
//  WelcomeViewController.swift
//  GoogleMapsCustomStyle
//
//  Created by Rohmat Suseno on 22/01/20.
//  Copyright © 2020 Rohmts. All rights reserved.
//

import UIKit
import LBTATools

class WelcomeViewController: LBTAFormController {
    
    let titleLabel = UILabel(text: "Welcome aboard",
                             font: .systemFont(ofSize: 28),
                             textColor: .black)
    let skipButton = UIButton(title: "Skip >", titleColor: .black, font: .systemFont(ofSize: 16), backgroundColor: .clear)
    let img = UIImageView(image: UIImage(named: "welcome_image"))
    let signUpButton = UIButton(title: "Create an account",
                                titleColor: .black,
                                font: .systemFont(ofSize: 16),
                                backgroundColor: .white,
                                target: nil,
                                action: nil)
    let signInButton = UIButton(title: "Sign In",
                                titleColor: .white,
                                font: .systemFont(ofSize: 16),
                                backgroundColor: #colorLiteral(red: 0.4274509804, green: 0.3843137255, blue: 0.9882352941, alpha: 1),
                                target: self,
                                action: #selector(handleSignIn))
    let orLabel = UILabel(text: "or", textAlignment: .center)
    let fbButton = UIButton(title: "Facebook",
                            titleColor: .gray,
                            backgroundColor: .white)
    let googleButton = UIButton(title: "Google",
                                titleColor: .gray,
                                backgroundColor: .white)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
        setupForm()
        
        skipButton.addTarget(self, action: #selector(handleSkipButton(_:)), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setupForm() {
        formContainerStackView.axis = .vertical
        formContainerStackView.spacing = 15
        formContainerStackView.layoutMargins = .init(top: 15, left: 0, bottom: 15, right: 0)
        
        // setup button
        signUpButton.constrainHeight(50)
        signUpButton.layer.cornerRadius = 10
        signInButton.constrainHeight(50)
        signInButton.layer.cornerRadius = 10
        fbButton.constrainWidth((UIScreen.main.bounds.width - 75) / 2)
        fbButton.constrainHeight(50)
        fbButton.layer.cornerRadius = 10
        googleButton.constrainWidth((UIScreen.main.bounds.width - 75) / 2)
        googleButton.constrainHeight(50)
        googleButton.layer.cornerRadius = 10
        
        let buttonStack = UIStackView(arrangedSubviews: [signUpButton, signInButton])
        buttonStack.axis = .vertical
        buttonStack.spacing = 20
        
        let socialStack = UIStackView(arrangedSubviews: [fbButton, googleButton])
        socialStack.spacing = 15
        
        // setup title and image
        let titleStack = UIStackView(arrangedSubviews: [titleLabel, UIView(), skipButton])
        let sv = UIStackView(arrangedSubviews: [titleStack.padLeft(30).padRight(15), img, buttonStack.padTop(30).padLeft(30).padRight(30), orLabel, socialStack.padLeft(30).padRight(30)])
        sv.axis = .vertical
        sv.spacing = 15
        
        formContainerStackView.addArrangedSubview(sv)
    }
    
    @objc func handleSignIn() {
        self.navigationController?.pushViewController(SignInViewController(), animated: true)
    }
    
    @objc func handleSkipButton(_ sender: UIButton) {
        self.navigationController?.pushViewController(MainViewController(), animated: true)
    }
}

#if DEBUG
import SwiftUI
struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice(.init(stringLiteral: "iPhone 11 Pro")).edgesIgnoringSafeArea(.all)
    }
    
    struct ContentView: UIViewControllerRepresentable {
        func makeUIViewController(context: UIViewControllerRepresentableContext<Welcome_Previews.ContentView>) -> UIViewController {
            return UINavigationController(rootViewController: WelcomeViewController())
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<Welcome_Previews.ContentView>) {
            
        }
    }
}

struct Welcome_Dark_Previews: PreviewProvider {
    static var previews: some View {
        ContentDarkView()
            .previewDevice(.init(stringLiteral: "iPhone 6s"))
            .edgesIgnoringSafeArea(.all).environment(\.colorScheme, .dark)
    }
    
    struct ContentDarkView: UIViewControllerRepresentable {
        func makeUIViewController(context: UIViewControllerRepresentableContext<Welcome_Dark_Previews.ContentDarkView>) -> UIViewController {
            return UINavigationController(rootViewController: WelcomeViewController())
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<Welcome_Dark_Previews.ContentDarkView>) {
            
        }
    }
}
#endif
