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
        
        
        var fetchRequest = NSFetchRequest(entityName: "Course")
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as
            AppDelegate).managedObjectContext {
                fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest,
                    managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
                fetchResultController.delegate = self
                var e: NSError?
                var result = fetchResultController.performFetch(&e)
                courses = fetchResultController.fetchedObjects as [Course]
                if result != true {
                    println(e?.localizedDescription)
                } }
        
        
        var sumCredits = 0 as Float
        var sumPoints = 0 as Float
        for course in courses{
            sumCredits += (course.credits as NSString).floatValue
            sumPoints += (course.qualitypoints as NSString).floatValue
        }
        totalCredits.text="\(sumCredits)"
        totalPoints.text="\(sumPoints)"
        gpa.text=NSString(format:"%.02f",(sumPoints/sumCredits))
        if gpa.text == "nan"{
            gpa.text = "0.00"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
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
        
        var cummulativeGpa = allPoints/allCreds as Float
        
        cumGpa.text=NSString(format:"%.02f",(cummulativeGpa))
        if cumGpa.text == "nan"{
            cumGpa.text = "0.00"
        }
        
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        print("Enter Pressed")
        textField.endEditing(true)
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField){
        if textField==self.totalCreditHours || textField==self.totalQualityPoints{
            self.view.frame.origin.y -= 150
        }
        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField==self.totalCreditHours || textField==self.totalQualityPoints{
            self.view.frame.origin.y += 150
        }
        
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row == 6){
            calcCumGPA_Clicked(UIButton())
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}
