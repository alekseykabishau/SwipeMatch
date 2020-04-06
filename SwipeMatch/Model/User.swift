//
//  User.swift
//  SwipeMatch
//
//  Created by Aleksey on 0322..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import UIKit

struct User: ProducesCardViewModel {
    let uid: String
    let name: String
    var age: Int?
    var profession: String?
    var imageUrl1: String?
    
    
    init(dictionary: [String: Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.name = dictionary["fullname"] as? String ?? ""
        self.age = dictionary["age"] as? Int
        self.profession = dictionary["profession"] as? String
        self.imageUrl1 = dictionary["imageUrl1"] as? String
    }
    
    
    func toCardViewModel() -> CardViewModel {
        
        let attributedText = NSMutableAttributedString(string: name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
        
        let ageString = age != nil ? String(age!) : "N/A"
        attributedText.append(NSAttributedString(string: " \(ageString)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
        
        let professionString = profession != nil ? String(profession!) : "Not Available"
        attributedText.append(NSAttributedString(string: "\n\(professionString)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
        
        return CardViewModel(imageNames: [imageUrl1 ?? ""], attributedString: attributedText, textAlignment: .left)
    }
}
