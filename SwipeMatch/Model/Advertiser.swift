//
//  Advertiser.swift
//  SwipeMatch
//
//  Created by Aleksey on 0324..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import UIKit

struct Advertiser {
    
    let title: String
    let brandName: String
    let posterPhotoName: String
    
    func toCardViewModel() -> CardViewModel {
        
        let attributedText = NSMutableAttributedString(string: title, attributes: [.font: UIFont.systemFont(ofSize: 34, weight: .heavy)])
        attributedText.append(NSAttributedString(string: "\n" + brandName, attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .bold)]))
        
        return CardViewModel(imageName: posterPhotoName, attributedString: attributedText, textAlignment: .center)
    }
}
