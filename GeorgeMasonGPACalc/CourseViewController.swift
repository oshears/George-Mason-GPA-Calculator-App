//
//  FirstViewController.swift
//  GeorgeMasonGPACalc
//
//  Created by Osaze Shears on 12/25/14.
//  Copyright (c) 2014 Osaze Shears. All rights reserved.
//

import UIKit
import CoreData

class CourseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    //Table on the first view
    @IBOutlet weak var tblCourses: UITableView!
    
    var courses:[Course] = []
    var newCoursePresent = false
    
    var fetchResultController:NSFetchedResultsController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblCourses.tableFooterView = UIView(frame:CGRectZero)
        // Do any additional setup after loading the view, typically from a nib.
        
        var fetchRequest = NSFetchRequest(entityName: "Course")
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as!
            AppDelegate).managedObjectContext {
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest,
            managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            var e: NSError?
            var result = fetchResultController.performFetch(&e)
            courses = fetchResultController.fetchedObjects as! [Course]
            if result != true {
                println(e?.localizedDescription)
            }
        }
        
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let hasViewedWalkthrough = defaults.boolForKey("hasViewedWalkthrough")
        if !hasViewedWalkthrough{
            if let helpPageViewController = storyboard?.instantiateViewControllerWithIdentifier("HelpPageViewController") as? HelpPageViewController {
                self.presentViewController(helpPageViewController, animated: true, completion: nil)
            }
        }
        
    }
    
    @IBAction func displayHelp(sender:AnyObject){
        if let helpPageViewController = storyboard?.instantiateViewControllerWithIdentifier("HelpPageViewController") as? HelpPageViewController {
                self.presentViewController(helpPageViewController, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Returning to view
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
                
        tblCourses.reloadData();
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //UITableViewDelete
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        /*if(editingStyle == UITableViewCellEditingStyle.Delete){
            courses.removeAtIndex(indexPath.row)
            tblCourses.reloadData()
        }*/
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        
        var deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete",handler: {
            (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            
            // Delete the row from the data source
            if let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext {
                
                let courseToDelete = self.fetchResultController.objectAtIndexPath(indexPath) as! Course
                managedObjectContext.deleteObject(courseToDelete)
                
                var e: NSError?
                if managedObjectContext.save(&e) != true {
                    println("delete error: \(e!.localizedDescription)")
                }
            }
            
        })
        
        deleteAction.backgroundColor = UIColor(red: 237.0/255.0, green: 75.0/255.0, blue: 27.0/255.0, alpha: 1.0)
        
        return [deleteAction]
    }
    
    //UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return courses.count
    }
    
    //The way the table and cells are displayed
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CustomCourseCell
        
        cell.courseName.text = courses[indexPath.row].title
        cell.courseCredits.text = "Credits: " + courses[indexPath.row].credits
        cell.courseGrade.text = "Grade: " + courses[indexPath.row].grade
        
        return cell
    }
    
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
            self.tblCourses.beginUpdates()
    }
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject,
            atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType,
            newIndexPath: NSIndexPath?) {
            switch type {
        case .Insert:
            var myArray:[NSIndexPath!] = [newIndexPath]
            self.tblCourses.insertRowsAtIndexPaths(myArray, withRowAnimation: UITableViewRowAnimation.Fade)
        case .Delete:
            var myArray:[NSIndexPath!] = [indexPath]
            self.tblCourses.deleteRowsAtIndexPaths(myArray, withRowAnimation: UITableViewRowAnimation.Fade)
        case .Update:
            var myArray:[NSIndexPath!] = [indexPath]
            self.tblCourses.reloadRowsAtIndexPaths(myArray, withRowAnimation: UITableViewRowAnimation.Fade)
        default:
            self.tblCourses.reloadData()
            }
            courses = controller.fetchedObjects as! [Course]
    }
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
            self.tblCourses.endUpdates()
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier=="editCourse"{
            
            if let row = tblCourses.indexPathForSelectedRow()?.row {
                //Get the destination navigation view controller
                let destinationController = segue.destinationViewController as! UINavigationController
                //Get the view controller from the destination navigation controller
                let newDestinationController = destinationController.viewControllers[0]as! EditCourseTableViewController
                let course:Course = courses[row]
                newDestinationController.course = course
                newDestinationController.selectedItemIndex = row
            
            
            }
            
        }
    }
    @IBAction func addCourse(sender:AnyObject){
        self.tabBarController?.selectedIndex = 2
    }
    
    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue) {
    }
    

}

