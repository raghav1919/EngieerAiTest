//
//  PostTableViewCell.swift
//  EngieerAIAssignment
//
//  Created by kushal mandala on 17/12/19.
//  Copyright © 2019 kushal mandala. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var title : UILabel?
    @IBOutlet weak var created_at : UILabel?
    @IBOutlet weak var toggle : UISwitch?    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
