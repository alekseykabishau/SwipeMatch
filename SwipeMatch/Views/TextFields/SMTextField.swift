//
//  SMTextField.swift
//  SwipeMatch
//
//  Created by Aleksey on 0328..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import UIKit

class SMTextField: UITextField {
    
    // 2 methods provide nice insets from left and right for text in text field
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 16, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 16, dy: 0)
    }
    
    override var intrinsicContentSize: CGSize {
        return .init(width: 0, height: 50)
    }
}
