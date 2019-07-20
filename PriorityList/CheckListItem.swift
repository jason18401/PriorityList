//
//  PriorityCell.swift
//  PriorityList
//
//  Created by Jason Yu on 7/12/19.
//  Copyright © 2019 Jason Yu. All rights reserved.
//

import UIKit

//we extend NSObject to compare items with other items
class CheckListItem: NSObject {
    
    @objc var text = ""
    var checked = false
    
    func toggleChecked(){
        checked = !checked
    }

}
