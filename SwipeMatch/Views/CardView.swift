//
//  CardView.swift
//  SwipeMatch
//
//  Created by Aleksey on 0322..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import UIKit
import SDWebImage

class CardView: UIView {
    
    var cardViewModel: CardViewModel! {
        didSet {
            
            if let url = URL(string: cardViewModel.imageNames.first ?? "") {
                imageView.sd_setImage(with: url)
            }
            
            infoLabel.attributedText = cardViewModel.attributedString
            infoLabel.textAlignment = cardViewModel.textAlignment
            
            (0..<cardViewModel.imageNames.count).forEach { (view) in
                let view = UIView()
                view.backgroundColor = Color.barDeselectedColor
                barsStackView.addArrangedSubview(view)
            }
            barsStackView.arrangedSubviews.first?.backgroundColor = .white
            
            cardViewModel.imageIndexObserver = { [weak self] (imageIndex, image) in
                guard let self = self else { return }
                print("changing photo from view model")
                self.imageView.image = image
                
                self.barsStackView.arrangedSubviews.forEach { $0.backgroundColor = Color.barDeselectedColor }
                self.barsStackView.arrangedSubviews[imageIndex].backgroundColor = .white
            }
        }
    }
    
    private let imageView = UIImageView()
    private let barsStackView = UIStackView()
    private let gradientLayer = CAGradientLayer()
    private let infoLabel = UILabel()
    
    private let threshold: CGFloat = 120
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 10
        clipsToBounds = true
        
        configureImageView()
        configureBarsStackView() // z-index important in this case
        setupGradientLayer() // z-index important in this case
        configureInfoLabel()
        
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    
    private func configureImageView() {
        addSubview(imageView)
        imageView.fillSuperview()
        imageView.contentMode = .scaleAspectFill
    }
    
    
    private func configureBarsStackView() {
        addSubview(barsStackView)
        barsStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 8), size: .init(width: 0, height: 4))
        barsStackView.spacing = 4
        barsStackView.distribution = .fillEqually
    }
    
    
    private func setupGradientLayer() {
        // frame is set in layoutSubviews
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1.1] // clear start at 50% and black goes below
        layer.addSublayer(gradientLayer)
    }
    
    
    private func configureInfoLabel() {
        addSubview(infoLabel)
        infoLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 0))
        infoLabel.textColor = .white
        infoLabel.font = UIFont.systemFont(ofSize: 34, weight: .heavy)
        infoLabel.numberOfLines = 0
    }
    
    
    // can get access to card frame property because it's set to .zero during init
    override func layoutSubviews() {
        gradientLayer.frame = self.frame
    }
    
    
    @objc private func handleTap(gesture: UITapGestureRecognizer) {
        
        let tapLocation = gesture.location(in: self)
        let shouldAdvanceNextPhoto = tapLocation.x > frame.width / 2 ? true : false
        if shouldAdvanceNextPhoto {
            cardViewModel.goToNextPhoto()
        } else {
            cardViewModel.goToPreviuosPhoto()
        }
    }
    
    
    @objc private func handlePan(gesture: UIPanGestureRecognizer) {
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
        
        let translationDirection: CGFloat = gesture.translation(in: nil).x > 0 ? 1 : -1
        let shouldDismissCard = abs(gesture.translation(in: nil).x) > threshold
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            if shouldDismissCard {
                self.transform = self.transform.translatedBy(x: 600 * translationDirection, y: 0)
            } else {
                self.transform = .identity
            }
        }, completion: { _ in
            if shouldDismissCard {
                self.removeFromSuperview()
            }
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
