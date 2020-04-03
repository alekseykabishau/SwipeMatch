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
    
    
    private func checkFormValidity() {
        let isFormValid = fullname?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        
        bindableIsFormValid.value = isFormValid
    }
    
    
    func performRegistration(completed: @escaping ((Error) -> Void)) {
        guard let email = email, let password = password else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (result, error) in
            
            guard let self = self else { return }
            if let error = error {
                completed(error)
                return
            }
            
            print("Success: \(result?.user.uid ?? "No UID is available")")
            
            guard let imageData = self.bindableImage.value?.jpegData(compressionQuality: 0.75) else { return }
            
            let filename = UUID().uuidString
            let reference = Storage.storage().reference(withPath: "/images/\(filename)")
            reference.putData(imageData, metadata: nil) { (_, error) in
                if let error = error {
                    completed(error)
                    return
                }
                print("Image upload has been completed")
                
                reference.downloadURL { (url, error) in
                    if let error = error {
                        completed(error)
                        return
                    }
                    print(url?.absoluteString ?? "For some reason URL is not avalable")
                }
            }
        }
    }
}
