//
//  Course.swift
//  GMUGPA
//
//  Created by Osaze Shears on 3/12/15.
//  Copyright (c) 2015 Osaze Shears. All rights reserved.
//

import Foundation
import CoreData





class Course:NSManagedObject {
    
    @NSManaged var title:String!
    @NSManaged var credits:String!
    @NSManaged var grade:String!
    @NSManaged var qualitypointvalue:String!
    @NSManaged var qualitypoints:String!
    @NSManaged var selected:NSNumber!
    
}