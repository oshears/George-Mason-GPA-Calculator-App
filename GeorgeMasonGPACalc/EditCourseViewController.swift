//
//  EditCourseViewController.swift
//  GeorgeMasonGPACalc
//
//  Created by Osaze Shears on 1/4/15.
//  Copyright (c) 2015 Osaze Shears. All rights reserved.
//

import UIKit

class EditCourseViewController: UIViewController {

    @IBOutlet weak var courseName: UITextField!
    
    @IBOutlet weak var courseGradePicker: UIPickerView!
    
    @IBOutlet weak var courseQualPtVal: UILabel!
    @IBOutlet weak var courseCredits: UITextField!
    
    var letterGrades = ["A+/A","A-","B+","B","B-","C+","C","C-","D","F"]
    var numberGrades = [4.00,3.67,3.33,3.00,2.67,2.33,2.00,1.67,1.00,0.00]
    var selectedItemIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        courseName.text = courseMgr.courses[courseMgr.selected].name
        courseQualPtVal.text = courseMgr.courses[courseMgr.selected].qualPtVal
        courseCredits.text = courseMgr.courses[courseMgr.selected].credits
        
        var pickerSelectNum = courseMgr.courses[courseMgr.selected].grade
        
        //var theIndex = (find(letterGrades, pickerSelectNum)!)
        //print(find(self.letterGrades, pickerSelectNum)!)
        

        if let index = find(self.letterGrades, pickerSelectNum){
            //println("We got" + String(index))
            //println("OOOOOk")
            //self.courseGradePicker.selectedRowInComponent(index)
            self.courseGradePicker.selectRow(index, inComponent: 0, animated: false)
            selectedItemIndex = index
        }
        
        
        
        
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int{
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return letterGrades.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!{
        return letterGrades[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        selectedItemIndex=row
        courseQualPtVal.text="\(numberGrades[row])"
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
            
            courseMgr.courses[courseMgr.selected].name=aString
            courseMgr.courses[courseMgr.selected].grade=bString
            courseMgr.courses[courseMgr.selected].qualPtVal=cString
            courseMgr.courses[courseMgr.selected].credits=dString
            courseMgr.courses[courseMgr.selected].qualPts=eString
            
            
            self.view.endEditing(true)
            
            courseName.text=""
            selectedItemIndex=0
            courseQualPtVal.text=""
            courseCredits.text=""
            
            //self.tabBarController?.selectedIndex=0
            //self.popViewControllerAnimated(true)
            self.dismissViewControllerAnimated(true, completion: nil)
            /*
            let vc : AnyObject! = self.storyboard?.instantiateViewControllerWithIdentifier("TabController")
            self.showViewController(vc as UIViewController, sender: vc)
            */
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        print("Enter Pressed")
        textField.endEditing(true)
        return true
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
