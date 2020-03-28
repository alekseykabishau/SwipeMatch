//
//  CardViewModel.swift
//  SwipeMatch
//
//  Created by Aleksey on 0323..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import UIKit

protocol ProducesCardViewModel {
    func toCardViewModel() -> CardViewModel
}


class CardViewModel {
    
    let imageNames: [String]
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
    
    // view model is supposed to represent the STATE of our View
    private var imageIndex = 0 {
        didSet {
            let image = UIImage(named: imageNames[imageIndex])
            imageIndexObserver?(imageIndex, image)
        }
    }
    
    // reactive programming
    var imageIndexObserver: ((Int, UIImage?) -> Void)?
    
    
    init(imageNames: [String], attributedString: NSAttributedString, textAlignment: NSTextAlignment) {
        self.imageNames = imageNames
        self.attributedString = attributedString
        self.textAlignment = textAlignment
    }
    
    
    func goToNextPhoto() {
        imageIndex = min(imageIndex + 1, imageNames.count - 1)
    }
    
    
    func goToPreviuosPhoto() {
        imageIndex = max(0, imageIndex - 1)
    }
    
}
