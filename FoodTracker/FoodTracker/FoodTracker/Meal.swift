//
//  Meal.swift
//  FoodTracker
//
//  Created by Jussi Vesa on 07/09/2017.
//  Copyright © 2017 Jussi Vesa. All rights reserved.
//

import UIKit


class Meal {
    
    //MARK: Properties
    var name: String
    var photo: UIImage? // Because a meal always has a name and rating but might not have a photo, make the UIImage an optional.
    var rating: Int
    
    //MARK: Initialization
    init?(name: String, photo: UIImage?, rating: Int) {
    
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || rating < 0  {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.rating = rating
    }

    
}
