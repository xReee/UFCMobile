//
//  ChatTableViewCell.swift
//  UFCMobile
//
//  Created by Renata on 31/05/18.
//  Copyright © 2018 Renata. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var txtTitulo: UILabel!
    @IBOutlet weak var txtUltimaMsg: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
