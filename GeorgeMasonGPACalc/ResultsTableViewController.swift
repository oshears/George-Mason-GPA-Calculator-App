//
//  ResultsTableViewController.swift
//  GMUGPA
//
//  Created by Osaze Shears on 3/14/15.
//  Copyright (c) 2015 Osaze Shears. All rights reserved.
//

import UIKit
import CoreData

class ResultsTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var totalCredits: UILabel!
    @IBOutlet weak var totalPoints: UILabel!
    @IBOutlet weak var gpa: UILabel!
    @IBOutlet weak var totalCreditHours: UITextField!
    @IBOutlet weak var totalQualityPoints: UITextField!
    @IBOutlet weak var cumGpa: UILabel!
    
    var courses:[Course] = []
    var fetchResultController:NSFetchedResultsController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        totalCreditHours.returnKeyType = UIReturnKeyType.Done
        totalQualityPoints.returnKeyType = UIReturnKeyType.Done
        
    }
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(true)
        
        
        let fetchRequest = NSFetchRequest(entityName: "Course")
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as!
            AppDelegate).managedObjectContext {
                fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest,
                    managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
                fetchResultController.delegate = self
                var e: NSError?
                var result: Bool
                do {
                    try fetchResultController.performFetch()
                    result = true
                } catch let error as NSError {
                    e = error
                    result = false
                }
                courses = fetchResultController.fetchedObjects as! [Course]
                if result != true {
                    print(e?.localizedDescription)
                } }
        
        
        var sumCredits = 0 as Float
        var sumPoints = 0 as Float
        for course in courses{
            sumCredits += (course.credits as NSString).floatValue
            sumPoints += (course.qualitypoints as NSString).floatValue
        }
        totalCredits.text="\(sumCredits)"
        totalPoints.text="\(sumPoints)"
        gpa.text=NSString(format:"%.02f",(sumPoints/sumCredits)) as String
        if gpa.text == "nan"{
            gpa.text = "0.00"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)

    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool{
        textField.resignFirstResponder();
        return true
    }
    
    @IBAction func calcCumGPA_Clicked(sender: AnyObject) {
        
        var allCreds = 0 as Float
        allCreds=(totalCredits.text! as NSString).floatValue+(self.totalCreditHours.text! as NSString).floatValue
        var allPoints = 0 as Float
        allPoints=(totalPoints.text! as NSString).floatValue + (self.totalQualityPoints.text! as NSString).floatValue
        
        let cummulativeGpa = allPoints/allCreds as Float
        
        cumGpa.text=NSString(format:"%.02f",(cummulativeGpa)) as String
        if cumGpa.text == "nan"{
            cumGpa.text = "0.00"
        }
        
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        print("Enter Pressed", terminator: "")
        textField.endEditing(true)
        return true
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row == 6){
            calcCumGPA_Clicked(UIButton())
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}
