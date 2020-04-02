//
//  RegistrationViewModel.swift
//  SwipeMatch
//
//  Created by Aleksey on 0330..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import UIKit

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
}
