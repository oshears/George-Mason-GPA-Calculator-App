//
//  HelpPageViewController.swift
//  GMUGPA
//
//  Created by Osaze Shears on 3/14/15.
//  Copyright (c) 2015 Osaze Shears. All rights reserved.
//

import UIKit

class HelpPageViewController: UIPageViewController, UIPageViewControllerDataSource {

    
    var pageHeadings = ["Add Courses", "Edit Courses", "Delete Courses","Calculate your GPA"]
    var pageImages = ["tut1", "tut2", "tut3","tut4"]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dataSource = self
        if let startingViewController = self.viewControllerAtIndex(0){
            setViewControllers([startingViewController], direction: .Forward, animated: true, completion: nil)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(pageViewController: UIPageViewController,
        viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
            var index = (viewController as TutorialViewController).index
            index++
            return self.viewControllerAtIndex(index)
    }
    func pageViewController(pageViewController: UIPageViewController,
        viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
            var index = (viewController as TutorialViewController).index
            index--
            return self.viewControllerAtIndex(index)
    }
    
    func viewControllerAtIndex(index: Int) -> TutorialViewController? {
        if index == NSNotFound || index < 0 || index >= self.pageHeadings.count {
            return nil
        }
        // Create a new view controller and pass suitable data.
        if let tutorialViewController = storyboard?.instantiateViewControllerWithIdentifier("TutorialViewController") as?
            TutorialViewController {
                tutorialViewController.imageFile = pageImages[index]
                tutorialViewController.helpText = pageHeadings[index]
                tutorialViewController.index = index
                return tutorialViewController
        }
        return nil
    }
    func forward(index: Int) {
        if let nextViewController = self.viewControllerAtIndex(index + 1) {
            setViewControllers([nextViewController], direction: .Forward, animated: true,
                completion: nil)
        }
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
