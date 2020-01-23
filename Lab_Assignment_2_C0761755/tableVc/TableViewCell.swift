//
//  TableViewCell.swift
//  Lab_Assignment_2_C0761755
//
//  Created by Anmol Sharma on 2020-01-22.
//  Copyright © 2020 anmol. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var totalDays: UILabel!
    @IBOutlet weak var daysCompleted: UILabel!
    @IBOutlet weak var daysLeft: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
