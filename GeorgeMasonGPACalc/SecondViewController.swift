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
        
        var sumCredits = 0 as Float
        var sumPoints = 0 as Float
        for course in courseMgr.courses{
            sumCredits += (course.credits as NSString).floatValue
            sumPoints += (course.credits as NSString).floatValue * (course.qualPtVal as NSString).floatValue
        }
        totalCredits.text="\(sumCredits)"
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }


}

