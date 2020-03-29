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
        textField.autocorrectionType = .no // keyboard height is less because of missing autocorrect section
        textField.layer.cornerRadius = 25
        return textField
    }()
    
    let passwordTextField: SMTextField = {
       let textField = SMTextField()
        textField.backgroundColor = .white
        textField.placeholder = "Enter password"
        textField.isSecureTextEntry = true // keyboardWillShowNotification called twice, first time with to no changes for keyboard frame (stays out of view) and different values to compare with second call
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
    
    var stackView = UIStackView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureGradientLayer()
        configureStackView()
        setupNotificationObservers()
        setupTabGesture()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self) // ! prevent retain cycle
    }
    
    
    private func setupTabGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
    }
    
    
    @objc private func handleTap() {
        self.view.endEditing(true)
        
    }
    
    
    private func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc private func handleKeyboardShow(notification: Notification) {
        /*
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = value.cgRectValue
        */
        
        
        // need to compare those values to avoid glitch with showing keyboard specifically for password type otherwise can user code above
        let userInfo = notification.userInfo
        guard
            let keyboardFrameBeginValue = userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue,
            let keyboardFrameEndValue = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
            keyboardFrameBeginValue.cgRectValue != keyboardFrameEndValue.cgRectValue else { return }
        
        let bottomSpace = view.frame.height - stackView.frame.origin.y - stackView.frame.height
        let distance = keyboardFrameEndValue.cgRectValue.height - bottomSpace
        
        self.view.transform = CGAffineTransform(translationX: 0, y: -distance - 8)
    }
    
    
    @objc private func handleKeyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.transform = .identity
        })
    }
    
    
    private func configureStackView() {
        stackView = UIStackView(arrangedSubviews: [selectPhotoButton, fullNameTextField, emailTextField, passwordTextField, registerButton])
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
