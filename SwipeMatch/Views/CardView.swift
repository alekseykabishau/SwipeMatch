//
//  CardView.swift
//  SwipeMatch
//
//  Created by Aleksey on 0322..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    private let imageView = UIImageView(image: #imageLiteral(resourceName: "kelly3"))
    
    // configuration
    private let threshold: CGFloat = 150

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 10
        clipsToBounds = true
        
        addSubview(imageView)
        imageView.fillSuperview()
        imageView.contentMode = .scaleAspectFill
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .changed:
            handleChange(gesture)
        case .ended:
            handleEnded(gesture)
        default:
            ()
        }
    }
    
    private func handleChange(_ gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: nil)

        let degrees: CGFloat = translation.x / 20
        let angle = degrees * .pi / 180
        
        let rotationalTransformation = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationalTransformation.translatedBy(x: translation.x, y: translation.y)
    }
    
    private func handleEnded(_ gesture: UIPanGestureRecognizer) {
        
        let shouldDisminssCard: Bool
        let translation = gesture.translation(in: nil)
        
        switch translation.x {
        case -threshold...threshold:
            shouldDisminssCard = false
        default:
            shouldDisminssCard = true
        }
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            if shouldDisminssCard {
                self.transform = self.transform.translatedBy(x: translation.x > 0 ? 1000 : -1000, y: 0)
            } else {
                self.transform = .identity
            }
        }, completion: { _ in
            self.transform = .identity
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
