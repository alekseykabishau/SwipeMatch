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
            handleChange(gesture: gesture)
        case .ended:
            handleEnded()
        default:
            ()
        }
    }
    
    private func handleChange(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: nil)
        self.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
    }
    
    private func handleEnded() {
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.transform = .identity
        }, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
