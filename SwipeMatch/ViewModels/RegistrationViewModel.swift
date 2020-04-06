//
//  RegistrationViewModel.swift
//  SwipeMatch
//
//  Created by Aleksey on 0330..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import UIKit
import Firebase

class Bindable<T> {
    
    var observer: ((T?) -> Void)?
    var value: T? { didSet { observer?(value) } }
    
    func bind(observer: @escaping (T?) -> Void) {
        self.observer = observer
    }
}

class RegistrationViewModel {
    
    var fullname: String? { didSet { checkFormValidity() } }
    var email: String? { didSet { checkFormValidity() } }
    var password: String? { didSet { checkFormValidity() } }
    
    var bindableImage = Bindable<UIImage>()
    var bindableIsFormValid = Bindable<Bool>()
    var bindableIsRegistering = Bindable<Bool>()
    
    
    private func checkFormValidity() {
        let isFormValid = fullname?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        
        bindableIsFormValid.value = isFormValid
    }
    
    
    func performRegistration(completed: @escaping ((Error?) -> Void)) {
        
        guard let email = email, let password = password else { return }
        bindableIsRegistering.value = true
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (result, error) in
            
            guard let self = self else { return }
            if let error = error {
                self.bindableIsRegistering.value = false
                completed(error)
                return
            }
            
            print("Success: \(result?.user.uid ?? "No UID is available")")
            
            self.saveImageToFirestore(completed: completed)
        }
    }
    
    private func saveImageToFirestore(completed: @escaping (Error?) -> Void) {
        
        guard let imageData = self.bindableImage.value?.jpegData(compressionQuality: 0.75) else { return }
        let filename = UUID().uuidString
        let reference = Storage.storage().reference(withPath: "/images/\(filename)")
        reference.putData(imageData, metadata: nil) { (_, error) in
            if let error = error {
                self.bindableIsRegistering.value = false
                completed(error)
                return
            }
            
            reference.downloadURL { (url, error) in
                if let error = error {
                    completed(error)
                    return
                }
                
                let imageUrl = url?.absoluteString ?? ""
                self.saveUserInfoToFirestore(imageUrl: imageUrl, completed: completed)
            }
        }
    }
    
    
    private func saveUserInfoToFirestore(imageUrl: String, completed: @escaping ((Error?) -> Void)) {
        
        let uid = Auth.auth().currentUser?.uid ?? ""
        let userData = ["fullname": fullname ?? "", "uid": uid, "imageUrl1": imageUrl]
        
        Firestore.firestore().collection("users").document(uid).setData(userData) { (error) in
            self.bindableIsRegistering.value = false
            if let error = error {
                completed(error)
                return
            }
            completed(nil)
        }
    }
}
