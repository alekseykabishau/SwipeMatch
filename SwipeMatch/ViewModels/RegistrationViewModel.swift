//
//  RegistrationViewModel.swift
//  SwipeMatch
//
//  Created by Aleksey on 0330..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import UIKit

class RegistrationViewModel {
    
    var fullname: String? { didSet { checkFormValidity() } }
    var email: String? { didSet { checkFormValidity() } }
    var password: String? { didSet { checkFormValidity() } }
    
    // reactive programming
    var isFormValidObserver: ((Bool) -> Void)?
    
    
    private func checkFormValidity() {
        let isFormValid = fullname?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        isFormValidObserver?(isFormValid)
    }
}
