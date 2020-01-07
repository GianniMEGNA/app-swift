//
//  CellTableViewCell.swift
//  PersonMsg
//
//  Created by Gianni MEGNA on 12/08/2019.
//  Copyright © 2019 Gianni MEGNA. All rights reserved.
//

import UIKit

class CellTableViewCell: UITableViewCell {

    @IBOutlet weak var labbel1: UILabel!
    @IBOutlet weak var labbel2: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
