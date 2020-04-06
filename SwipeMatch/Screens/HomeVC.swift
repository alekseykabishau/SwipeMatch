//
//  HomeVC.swift
//  SwipeMatch
//
//  Created by Aleksey on 0321..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import UIKit
import Firebase

class HomeVC: UIViewController {
    
    let topStackView = TopNavigationStackView()
    let cardDeckView = UIView()
    let buttonsStackView = HomeButtomControlsStackView()
    
    var cardViewModels = [CardViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureStackView()
        fetchUsersFromFirestore()
    }
    
    
    func fetchUsersFromFirestore() {
        Firestore.firestore().collection("users").getDocuments { (snapshot, error) in
            if let error = error {
                print("snapshot error: \(error)")
                return
            }
            
            snapshot?.documents.forEach({ (documentSnapshot) in
                let userData = documentSnapshot.data()
                let user = User(dictionary: userData)
                self.cardViewModels.append(user.toCardViewModel())
                print(user)
            })
            
            self.setupCards()
        }
    }
    
    
    private func setupCards() {
        
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

