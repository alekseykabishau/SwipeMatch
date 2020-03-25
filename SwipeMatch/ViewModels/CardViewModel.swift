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

struct CardViewModel {
    // define properties that view will display/render out
    
    let imageName: String
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
}
