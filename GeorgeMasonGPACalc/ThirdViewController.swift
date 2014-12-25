//
//  ThirdViewController.swift
//  GeorgeMasonGPACalc
//
//  Created by Osaze Shears on 12/25/14.
//  Copyright (c) 2014 Osaze Shears. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var courseName: UITextField!
    @IBOutlet weak var gradePicker: UIPickerView!
    @IBOutlet weak var qualityPointValue: UILabel!
    @IBOutlet weak var courseCredit: UITextField!
    
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
        qualityPointValue.text="\(numberGrades[row])"
    }
    
    //When user touches out of edit box
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    @IBAction func addCourseBtn_Click(sender: AnyObject) {
        
        var notBlank = courseName.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) != "" && courseCredit.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) != ""
        
        if (notBlank){
            var aString=courseName.text
            var bString=letterGrades[selectedItemIndex]
            var cString="\(numberGrades[selectedItemIndex)"
            var dString=courseCredit.text
            
            var credFloat = (dString as NSString).floatValue
            var qpValFloat = Float(numberGrades[selectedItemIndex])
            var result = credFloat * qpValFloat
            var eString="\(result)"
            
            courseMgr.addCourse(aString, grade: bString, qpv: cString, creds: dString, qpts: eString)
            self.view.endEditing(true)
            
            courseName.text=""
            selectedItemIndex=0
            qualityPointValue.text="4.0"
            courseCredit.text=""
            gradePicker.selectRow(0, inComponent: 0, animated: true)

            self.tabBarController?.selectedIndex=0
        }
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool{
        textField.resignFirstResponder();
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
