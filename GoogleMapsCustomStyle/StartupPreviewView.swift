//
//  StartupPreviewView.swift
//  GoogleMapsCustomStyle
//
//  Created by Rohmat Suseno on 23/01/20.
//  Copyright © 2020 Rohmts. All rights reserved.
//

import UIKit
import LBTATools

class StartupPreviewView: UIView {
    
    let containerView: UIView = {
        let v=UIView()
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    
    let imgView: UIImageView = {
        let v=UIImageView()
        v.image=#imageLiteral(resourceName: "signin_image")
        v.contentMode = .scaleAspectFill
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    
    let lblTitle: UILabel = {
        let lbl=UILabel()
        lbl.text = "Name"
        lbl.font=UIFont.boldSystemFont(ofSize: 18)
        lbl.textColor = UIColor.black
        lbl.backgroundColor = UIColor.white
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor=UIColor.clear
        self.layer.cornerRadius = 10
        self.clipsToBounds=true
        self.layer.masksToBounds=true
        setupViews()
    }
    
    func setData(title: String, img: UIImage) {
        lblTitle.text = title
        imgView.image = img
    }
    
    func setupViews() {
        addSubview(containerView)
        containerView.leftAnchor.constraint(equalTo: leftAnchor).isActive=true
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive=true
        containerView.rightAnchor.constraint(equalTo: rightAnchor).isActive=true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive=true
        
        imgView.layer.cornerRadius = 10
        imgView.clipsToBounds = true
        
        containerView.addSubview(lblTitle)
        lblTitle.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0).isActive=true
        lblTitle.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0).isActive=true
        lblTitle.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0).isActive=true
        lblTitle.heightAnchor.constraint(equalToConstant: 35).isActive=true
        
        addSubview(imgView)
        imgView.leftAnchor.constraint(equalTo: leftAnchor).isActive=true
        imgView.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 5).isActive=true
        imgView.rightAnchor.constraint(equalTo: rightAnchor).isActive=true
        imgView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive=true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#if DEBUG
import SwiftUI
struct Startup_Preview: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice(.init(stringLiteral: "iPhone 6s Plus"))
    }
    
    struct ContentView: UIViewRepresentable {
        func makeUIView(context: UIViewRepresentableContext<Startup_Preview.ContentView>) -> UIView {
            return StartupPreviewView()
        }
        
        func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<Startup_Preview.ContentView>) {
            
        }
    }
}
#endif

//class StartupPreviewView: UIView {
//
//    let titleLabel = UILabel(text: "Startup name", font: .boldSystemFont(ofSize: 18), textColor: .black)
//    let descLabel = UILabel(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", font: .systemFont(ofSize: 16), textColor: .gray, numberOfLines: 0)
//    let imageView = UIImageView(image: #imageLiteral(resourceName: "welcome_image"), contentMode: .scaleAspectFill)
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.backgroundColor=UIColor.clear
//        self.clipsToBounds=true
//        self.layer.masksToBounds=true
//        setupViews()
//    }
//
//    private func setupViews() {
//        stack(imageView,
//              stack(titleLabel,
//                    descLabel,
//                    spacing: 8).padLeft(15),
//              UIView(),
//              spacing: 10)
//            //.withMargins(.allSides(0))
//    }
//
//    func setData(title: String, img: UIImage) {
//        imageView.image = img
//        titleLabel.text = title
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
