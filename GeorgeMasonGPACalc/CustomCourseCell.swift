//
//  CustomCourseCell.swift
//  GeorgeMasonGPACalc
//
//  Created by Osaze Shears on 1/3/15.
//  Copyright (c) 2015 Osaze Shears. All rights reserved.
//

import UIKit

class CustomCourseCell: UITableViewCell {

    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var courseGrade: UILabel!
    @IBOutlet weak var courseCredits: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
