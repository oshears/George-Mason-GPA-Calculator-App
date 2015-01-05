//
//  FirstViewController.swift
//  GeorgeMasonGPACalc
//
//  Created by Osaze Shears on 12/25/14.
//  Copyright (c) 2014 Osaze Shears. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //Table on the first view
    @IBOutlet weak var tblCourses: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Returning to view
    override func viewWillAppear(animated: Bool) {
        tblCourses.reloadData();
    }
    
    //UITableViewDelete
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        if(editingStyle == UITableViewCellEditingStyle.Delete){
            courseMgr.courses.removeAtIndex(indexPath.row)
            tblCourses.reloadData()
        }
    }
    
    //UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return courseMgr.courses.count
    }
    
    //The way the table and cells are displayed
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as CustomCourseCell
        
        //cell.textLabel?.text = courseMgr.courses[indexPath.row].name
        
        //var detailString = "Grade: " + courseMgr.courses[indexPath.row].grade + "\t Credits: " + courseMgr.courses[indexPath.row].credits + "\t Quality Points: " + courseMgr.courses[indexPath.row].qualPts
            
        //cell.detailTextLabel?.text = detailString
        
        cell.courseName.text = courseMgr.courses[indexPath.row].name
        cell.courseCredits.text = "Credits: " + courseMgr.courses[indexPath.row].credits
        cell.courseGrade.text = "Grade: " + courseMgr.courses[indexPath.row].grade
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        courseMgr.selected=indexPath.row
        let vc : AnyObject! = self.storyboard?.instantiateViewControllerWithIdentifier("EditCourse")
        self.showViewController(vc as UIViewController, sender: vc)

    }

}

