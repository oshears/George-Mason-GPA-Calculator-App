//
//  CouseManager.swift
//  GeorgeMasonGPACalc
//
//  Created by Osaze Shears on 12/25/14.
//  Copyright (c) 2014 Osaze Shears. All rights reserved.
//

import UIKit

var courseMgr: CourseManager = CourseManager()

struct course{
    var name = "No name"
    var grade = "No grade"
    var qualPtVal = "No quality point value"
    var credits = "No credits"
    var qualPts = "No quality points"
}

class CourseManager: NSObject {
    
    var courses = [course]()
    var selected = -1
    
    func addCourse(name: String, grade: String,qpv: String,creds: String,qpts: String){
        
        courses.append(course(name: name, grade: grade, qualPtVal: qpv, credits: creds, qualPts: qpts))
        
    }
}