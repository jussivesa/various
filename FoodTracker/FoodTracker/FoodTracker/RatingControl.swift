//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Jussi Vesa on 28/02/2017.
//  Copyright © 2017 Jussi Vesa. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    //MARK: Properties
    private var ratingButtons = [UIButton]()
    
    @IBInspectable var rateIconSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }
    
    @IBInspectable var rateIconCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    
    // property observer to the rating property, and have it call the updateButtonSelectionStates() method whenever the rating changes.
    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    
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
        print("btn pressed 🍋");
        
        guard let index = ratingButtons.index(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
        // Calculate the rating of the selected button
        let selectedRating = index + 1
        
        if selectedRating == rating {
            // If the selected lemon represents the current rating, reset the rating to 0.
            rating = 0
        } else {
            // Otherwise set the rating to the selected lemon
            rating = selectedRating
        }
    }
    
    //MARK: Private Methods
    private func setupButtons() {
        // clear any existing buttons
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        // Load Button Images
        let bundle = Bundle(for: type(of: self))
        let filledIcon = UIImage(named: "filledLemon", in: bundle, compatibleWith: self.traitCollection)
        let emptyIcon = UIImage(named:"emptyLemon", in: bundle, compatibleWith: self.traitCollection)
        let highlightedIcon = UIImage(named:"highlightedLemon", in: bundle, compatibleWith: self.traitCollection)
        
       
        for index in 0..<rateIconCount {
            //Create btn
            let button = UIButton()
            // Set the button images
            button.setImage(emptyIcon, for: .normal)
            button.setImage(filledIcon, for: .selected)
            button.setImage(highlightedIcon, for: .highlighted)
            button.setImage(highlightedIcon, for: [.highlighted, .selected])
            // button.backgroundColor = UIColor.orange;
            // button.setTitle("Rate meal", for: UIControlState.normal);
            // button.setTitleColor(UIColor.black, for: UIControlState.normal);
            //Add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: rateIconSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: rateIconSize.width).isActive = true
            
            // Set the accessibility label
            button.accessibilityLabel = "Set \(index + 1) lemon rating"
            
            //Setup btn action
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            //Add btn to the stack
            addArrangedSubview(button)
            
            // Add the new button to the rating button array
            ratingButtons.append(button)
            
            updateButtonSelectionStates()
            
        }
    }
    
    private func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            // If the index of a button is less than the rating, that button should be selected.
            button.isSelected = index < rating
            
            // Set the hint string for the currently selected lemon
            let hintString: String?
            if rating == index + 1 {
                hintString = "Tap to reset the rating to zero."
            } else {
                hintString = nil
            }
            
            // Calculate the value string
            let valueString: String
            switch (rating) {
            case 0:
                valueString = "No rating set."
            case 1:
                valueString = "1 lemon set."
            default:
                valueString = "\(rating) lemons set."
            }
            
            // Assign the hint string and value string
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }
}
