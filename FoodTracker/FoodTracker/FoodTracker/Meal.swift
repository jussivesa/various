//
//  Meal.swift
//  FoodTracker
//
//  Created by Jussi Vesa on 07/09/2017.
//  Copyright © 2017 Jussi Vesa. All rights reserved.
//

import UIKit
import os.log

// NSObject to subclass from the NSObject class, adopt the NSCoding protocol
class Meal: NSObject, NSCoding {
    
    //MARK: Properties
    var name: String
    var photo: UIImage? // Because a meal always has a name and rating but might not have a photo, make the UIImage an optional.
    var rating: Int
    var body: String? // Optional
    var date: String? // Optional
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    //MARK: Types
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
        static let body = "body"
        static let date = "date"
    }
    
    //MARK: Initialization
    init?(name: String, photo: UIImage?, rating: Int, body: String?, date: String?) {
    
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || rating < 0  {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.rating = rating
        self.body = body
        self.date = date
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
        aCoder.encode(body, forKey: PropertyKey.body)
        aCoder.encode(date, forKey: PropertyKey.date)
    }
    
    // The required modifier means this initializer must be implemented on every subclass, if the subclass defines its own initializers.
    // The convenience modifier means that this is a secondary initializer, and that it must call a designated initializer from the same class.
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because photo is an optional property of Meal, just use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        
        let body = aDecoder.decodeObject(forKey: PropertyKey.body) as? String
        let date = aDecoder.decodeObject(forKey: PropertyKey.date) as? String
        
        // Must call designated initializer.
        self.init(name: name, photo: photo, rating: rating, body: body, date: date)
    }

    
}
