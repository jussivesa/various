//
//  RatingControll.swift
//  FoodTracker
//
//  Created by Jussi Vesa on 28/02/2017.
//  Copyright © 2017 Jussi Vesa. All rights reserved.
//

import UIKit

class RatingControll: UIStackView {
    // There’s a corresponding initializer for each approach: init(frame:) for programatically initializing the view and init?(coder:) for loading the view from the storyboard. Recall that an initializer is a method that prepares an instance of a class for use, which involves setting an initial value for each property and performing any other setup.
    
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    //MARK: Button Action
    func ratingButtonTapped(button: UIButton) {
        print("btn pressed ✌️")
    }
    
    //MARK: Private Methods
    private func setupButtons() {
        //Create btn
        let button = UIButton()
        button.backgroundColor = UIColor.yellow
        
        //Add constraints
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        //Add btn to the stack
        addArrangedSubview(button)
        
        //Setup btn action
        button.addTarget(self, action: #selector(RatingControll.ratingButtonTapped(button:)), for: .touchUpInside)
    }
}
