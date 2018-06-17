//
//  OpcoesTableViewCell.swift
//  UFCMobile
//
//  Created by Renata on 17/06/2018.
//  Copyright © 2018 Renata. All rights reserved.
//

import UIKit

class OpcoesTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        txtOpValor.sizeToFit()
    }
    @IBOutlet weak var txtOpNome: UILabel!
    @IBOutlet weak var txtOpValor: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
