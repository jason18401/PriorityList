//
//  TableViewCell.swift
//  PriorityList
//
//  Created by Jason Yu on 7/19/19.
//  Copyright © 2019 Jason Yu. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var todoTextLabel: UILabel!
    @IBOutlet weak var checkmarkLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
