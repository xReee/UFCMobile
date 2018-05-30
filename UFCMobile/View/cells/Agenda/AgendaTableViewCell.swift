//
//  AgendaTableViewCell.swift
//  UFCMobile
//
//  Created by Renata on 27/05/18.
//  Copyright © 2018 Renata. All rights reserved.
//

import UIKit

class AgendaTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        viewStatus.layer.borderWidth = 2
        viewStatus.layer.borderColor = UIColor.white.cgColor
        // Initialization code
    }
    @IBOutlet weak var viewStatus: UIView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
