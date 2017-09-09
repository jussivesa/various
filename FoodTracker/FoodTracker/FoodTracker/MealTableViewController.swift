//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Jussi Vesa on 07/09/2017.
//  Copyright © 2017 Jussi Vesa. All rights reserved.
//

import UIKit
import os.log

class MealTableViewController: UITableViewController {
    
    //MARK: Properties
    
    // Default, an empty array of Meal objects
    var meals = [Meal]()    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Load any saved meals, otherwise load sample data.
        if let savedMeals = loadMeals() {
            meals += savedMeals
        } else {
            // Load the sample data.
            loadSampleMeals()
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    // tells the table view how many sections to display
    override func numberOfSections(in tableView: UITableView) -> Int {
        // Display single selection
        return 1
    }

    // tells the table view how many rows to display in a given section.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }

    // configures and provides a cell to display for a given row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "MealTableViewCell"
        
        // Because you created a custom cell class that you want to use, downcast the type of the cell to your custom cell subclass, MealTableViewCell.
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }

        // Fetches the appropriate meal for the data source layout.
        let meal = meals[indexPath.row]
        
        // Configure the cell...
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating
        
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            meals.remove(at: indexPath.row)
            // And save the data as item is deleted
            saveMeals()
            // deletes the corresponding row from the table view (UI only)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            // If the user is adding an item to the meal list, you don’t need to change the meal detail scene’s appearance. Just log a simple debug message to the console. This will help you track the app’s flow if you have to debug your code.
            case "AddItem":
                os_log("Adding a new meal", log: OSLog.default, type: .debug)
            case "ShowDetail":
                guard let mealDetailViewController = segue.destination as? MealViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")
                }
                
                guard let selectedMealCell = sender as? MealTableViewCell else {
                    fatalError("Unexpected sender: \(String(describing: sender))")
                }
                
                guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                    fatalError("The selected cell is not being displayed by the table")
                }
                
                let selectedMeal = meals[indexPath.row]
                mealDetailViewController.meal = selectedMeal
            default:
                fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")

        }
    }
    
    
    //MARK: Private Methods
    
    private func loadSampleMeals() {
        
        let photo1 = UIImage(named: "meal1")
        let photo2 = UIImage(named: "meal2")
        let photo3 = UIImage(named: "meal3")
        let photo4 = UIImage(named: "meal4")
        let photo5 = UIImage(named: "meal5")
        let photo6 = UIImage(named: "meal6")
        
        guard let meal1 = Meal(name: "Deer Filé", photo: photo1, rating: 4, body: "This meal was wonderful!", date: nil) else {
            fatalError("Unable to instantiate meal1")
        }
        
        guard let meal2 = Meal(name: "Mac n' Cheese", photo: photo2, rating: 2, body: "Superb", date: nil) else {
            fatalError("Unable to instantiate meal2")
        }
        
        guard let meal3 = Meal(name: "Pulled Pork Pasta", photo: photo3, rating: 3, body: "Nah not so good if I recal correctly..", date: nil) else {
            fatalError("Unable to instantiate meal3")
        }
        
        guard let meal4 = Meal(name: "Pizza Mamma Mia", photo: photo4, rating: 5, body: "Simple, lovely!", date: nil) else {
            fatalError("Unable to instantiate meal4")
        }
        
        guard let meal5 = Meal(name: "Cold Porridge", photo: photo5, rating: 1, body: "Nono.. not good.", date: nil) else {
            fatalError("Unable to instantiate meal5")
        }
        guard let meal6 = Meal(name: "Potatoes", photo: photo6, rating: 4, body: "Taysty! Yam", date: nil) else {
            fatalError("Unable to instantiate meal6")
        }

        
        // Add to array
        meals += [meal1, meal2, meal3, meal4, meal5, meal6]

    }
    
    private func saveMeals() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }
    
    //MARK: Actions
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? MealViewController, let meal = sourceViewController.meal {
            // This code computes the location in the table view where the new table view cell representing the 
            // new meal will be inserted, and stores it in a local constant called newIndexPath.
            
            // This code checks whether a row in the table view is selected. If it is, that means a user tapped one of the table views cells to edit a meal
            
            // Editing meal
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                meals[selectedIndexPath.row] = meal
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                // Add a new meal.
                let newIndexPath = IndexPath(row: meals.count, section: 0)
                meals.append(meal)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            // Save the meals nontheless new or edited
            saveMeals()
        }
    }
    
    // This method has a return type of an optional array of Meal objects, meaning that it might return an array of Meal objects or might return nothing (nil).
    private func loadMeals() -> [Meal]? {
        // This method attempts to unarchive the object stored at the path Meal.ArchiveURL.path and downcast that object to an array of Meal objects
        return NSKeyedUnarchiver.unarchiveObject(withFile: Meal.ArchiveURL.path) as? [Meal]
    }
    
}
