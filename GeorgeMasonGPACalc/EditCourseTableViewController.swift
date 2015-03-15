//
//  EditCourseTableViewController.swift
//  GMUGPA
//
//  Created by Osaze Shears on 3/12/15.
//  Copyright (c) 2015 Osaze Shears. All rights reserved.
//

import UIKit
import CoreData

class EditCourseTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var courseName: UITextField!
    
    @IBOutlet weak var courseGradePicker: UIPickerView!
    
    @IBOutlet weak var courseQualPtVal: UILabel!
    @IBOutlet weak var courseCredits: UITextField!
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    
    var letterGrades = ["A+/A","A-","B+","B","B-","C+","C","C-","D","F"]
    var numberGrades = [4.00,3.67,3.33,3.00,2.67,2.33,2.00,1.67,1.00,0.00]
    var selectedItemIndex = 0
    var course:Course!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        courseName.returnKeyType = UIReturnKeyType.Done
        courseCredits.returnKeyType = UIReturnKeyType.Done
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        if course != nil{
            courseName.text = course.title
            courseQualPtVal.text = course.qualitypointvalue
            courseCredits.text = course.credits
            
            var pickerSelectNum = course.grade
            
            
            if let index = find(self.letterGrades, pickerSelectNum){
                self.courseGradePicker.selectRow(index, inComponent: 0, animated: false)
                selectedItemIndex = index
            }
        }
        
        
        
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!{
        return letterGrades[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        selectedItemIndex=row
        courseQualPtVal.text="\(numberGrades[row])"
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return letterGrades.count
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    //When user touches out of edit box
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func doneEditingBtn_Click(sender: UIButton) {
        
        var notBlank = courseName.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) != "" && courseCredits.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) != ""
        
        if (notBlank){
            var aString=courseName.text
            var bString=letterGrades[selectedItemIndex]
            var cString="\(numberGrades[selectedItemIndex)"
            var dString=courseCredits.text
            
            var credFloat = (dString as NSString).floatValue
            var qpValFloat = Float(numberGrades[selectedItemIndex])
            var result = credFloat * qpValFloat
            var eString="\(result)"
            
            course.title=aString
            course.grade=bString
            course.qualitypointvalue=cString
            course.credits=dString
            course.qualitypoints=eString
            
            
            self.view.endEditing(true)
            
            courseName.text=""
            selectedItemIndex=0
            courseQualPtVal.text=""
            courseCredits.text=""
            
            managedObjectContext?.save(nil)
            
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.endEditing(true)
        return true
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    


}
