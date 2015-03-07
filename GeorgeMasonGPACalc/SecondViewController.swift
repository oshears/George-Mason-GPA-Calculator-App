//
//  SecondViewController.swift
//  GeorgeMasonGPACalc
//
//  Created by Osaze Shears on 12/25/14.
//  Copyright (c) 2014 Osaze Shears. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var totalCredits: UILabel!
    @IBOutlet weak var totalPoints: UILabel!
    @IBOutlet weak var gpa: UILabel!
    @IBOutlet weak var totalCreditHours: UITextField!
    @IBOutlet weak var totalQualityPoints: UITextField!
    @IBOutlet weak var cumGpa: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(true)
        
        var sumCredits = 0 as Float
        var sumPoints = 0 as Float
        for course in courseMgr.courses{
            sumCredits += (course.credits as NSString).floatValue
            sumPoints += (course.qualPts as NSString).floatValue
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


}

