//
//  RegistrationVC.swift
//  SwipeMatch
//
//  Created by Aleksey on 0328..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import UIKit

class RegistrationVC: UIViewController {
    
    let selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Photo", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 250).isActive = true
        button.layer.cornerRadius = 16
        return button
    }()
    
    let fullNameTextField: SMTextField = {
       let textField = SMTextField()
        textField.backgroundColor = .white
        textField.placeholder = "Enter full name"
        textField.layer.cornerRadius = 25
        return textField
    }()
    
    let emailTextField: SMTextField = {
       let textField = SMTextField()
        textField.backgroundColor = .white
        textField.placeholder = "Enter email"
        textField.keyboardType = .emailAddress
        textField.layer.cornerRadius = 25
        return textField
    }()
    
    let passwordTextField: SMTextField = {
       let textField = SMTextField()
        textField.backgroundColor = .white
        textField.placeholder = "Enter password"
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 25
        return textField
    }()
    
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemPink
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureGradientLayer()
        
        let stackView = UIStackView(arrangedSubviews: [selectPhotoButton, fullNameTextField, emailTextField, passwordTextField, registerButton])
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 8
        
        stackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 50, bottom: 0, right: 50))
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    
    private func configureGradientLayer() {
        let gradientLayer = CAGradientLayer()
        let topColor = #colorLiteral(red: 0.9921568627, green: 0.3450980392, blue: 0.3725490196, alpha: 1).cgColor
        let bottomColor = #colorLiteral(red: 0.8980392157, green: 0, blue: 0.4470588235, alpha: 1).cgColor
        gradientLayer.colors = [topColor, bottomColor]
        gradientLayer.locations = [0, 1]
        view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = view.bounds
    }
}
