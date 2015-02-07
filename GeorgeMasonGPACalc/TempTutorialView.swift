//
//  TempTutorialView.swift
//  GMUGPA
//
//  Created by Osaze Shears on 1/28/15.
//  Copyright (c) 2015 Osaze Shears. All rights reserved.
//

import UIKit

class TempTutorialView: UIViewController {

    var num = 0;
    var images = ["tut1","tut2","tut3","tut4"]
    
    @IBOutlet weak var tutImages: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tutImages.image = UIImage(named: images[0])
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        self.num+=1
        if num == 4{
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        else{
            self.tutImages.image = UIImage(named: images[num])
        }
        
    }
    override func prefersStatusBarHidden() -> Bool {
        
        return true;
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
