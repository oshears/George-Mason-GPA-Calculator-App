//
//  FirstViewController.swift
//  GeorgeMasonGPACalc
//
//  Created by Osaze Shears on 12/25/14.
//  Copyright (c) 2014 Osaze Shears. All rights reserved.
//

import UIKit
import CoreData

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

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
    
    //UITableViewDelete
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        if(editingStyle == UITableViewCellEditingStyle.Delete){
            courses.removeAtIndex(indexPath.row)
            tblCourses.reloadData()
        }
    }
    
    //UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return courses.count
    }
    
    //The way the table and cells are displayed
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as CustomCourseCell
        
        cell.courseName.text = courses[indexPath.row].title
        cell.courseCredits.text = "Credits: " + courses[indexPath.row].credits
        cell.courseGrade.text = "Grade: " + courses[indexPath.row].grade
        
        return cell
    }
    
    @IBAction func helpBtn_Click(sender: UIButton) {
        let vc : AnyObject! = self.storyboard?.instantiateViewControllerWithIdentifier("TempTutorial")
        self.showViewController(vc as UIViewController, sender: vc)
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController!) {
            self.tblCourses.beginUpdates()
    }
    func controller(controller: NSFetchedResultsController!, didChangeObject anObject: AnyObject!,
            atIndexPath indexPath: NSIndexPath!, forChangeType type: NSFetchedResultsChangeType,
            newIndexPath: NSIndexPath!) {
            switch type {
        case .Insert:
            self.tblCourses.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Fade)
        case .Delete:
            self.tblCourses.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        case .Update:
            self.tblCourses.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        default:
            self.tblCourses.reloadData()
            }
            courses = controller.fetchedObjects as [Course]
    }
    func controllerDidChangeContent(controller: NSFetchedResultsController!) {
            self.tblCourses.endUpdates()
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier=="editCourse"{
            if let row = tblCourses.indexPathForSelectedRow()?.row {
                let destinationController:EditCourseViewController = segue.destinationViewController as EditCourseViewController
            //let newDestinationController:EditCourseViewController
                let course:Course = fetchResultController.objectAtIndexPath(tblCourses.indexPathForSelectedRow()!) as Course
                destinationController.course = course
                destinationController.selectedItemIndex = row
            }
        }
    }
    
    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue) {
    }
    

}

