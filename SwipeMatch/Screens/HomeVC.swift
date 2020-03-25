//
//  HomeVC.swift
//  SwipeMatch
//
//  Created by Aleksey on 0321..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    let topStackView = TopNavigationStackView()
    let cardDeckView = UIView()
    let buttonsStackView = HomeButtomControlsStackView()
    
    let cardViewModels: [CardViewModel] = {
        let producers = [
        User(name: "Kelly", age: 23, profession: "Music DJ", imageName: "kelly1"),
        User(name: "Jane", age: 18, profession: "Teacher", imageName: "jane1"),
        Advertiser(title: "Slide Out Menu", brandName: "Let's Build That App", posterPhotoName: "slide_out_menu_poster")
        ] as [ProducesCardViewModel]
        
        let viewModels = producers.map { return $0.toCardViewModel() }
        return viewModels
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureStackView()
        setupDummyCards()
    }
    
    private func setupDummyCards() {
        
        cardViewModels.forEach { (cardViewModel) in
            let cardView = CardView(frame: .zero)
            cardView.cardViewModel = cardViewModel
            cardDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }
    }
    
    private func configureStackView() {
        let overallstackView = UIStackView(arrangedSubviews: [topStackView, cardDeckView, buttonsStackView])
        overallstackView.axis = .vertical
        
        view.addSubview(overallstackView)
        overallstackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        overallstackView.isLayoutMarginsRelativeArrangement = true
        overallstackView.layoutMargins = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        
        overallstackView.bringSubviewToFront(cardDeckView) // overlay buttons when card is moving
    }
}

