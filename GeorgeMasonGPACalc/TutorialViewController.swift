//
//  TempTutorialView.swift
//  GMUGPA
//
//  Created by Osaze Shears on 1/28/15.
//  Copyright (c) 2015 Osaze Shears. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {

    
    @IBOutlet weak var helpLabel:UILabel!
    @IBOutlet weak var contentImageView:UIImageView!
    @IBOutlet weak var getStartedButton:UIButton!
    
    var index : Int = 0
    var helpText : String = ""
    var imageFile : String = ""
    
    @IBOutlet weak var pageControl:UIPageControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        helpLabel.text = helpText
        contentImageView.image = UIImage(named: imageFile)
        
        // Do any additional setup after loading the view.
        
        pageControl.currentPage = index
        
        getStartedButton.hidden = (index == 3) ? false : true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(true, forKey: "hasViewedWalkthrough")
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func nextScreen(sender: AnyObject) {
        let pageViewController = self.parentViewController as! HelpPageViewController
        pageViewController.forward(index)
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
