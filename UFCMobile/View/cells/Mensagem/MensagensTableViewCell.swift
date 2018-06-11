//
//  MensagensTableViewCell.swift
//  UFCMobile
//
//  Created by Renata on 08/06/2018.
//  Copyright © 2018 Renata. All rights reserved.
//

import UIKit

class MensagensTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        txtMensagem.sizeToFit()
        // Initialization code
    }
    @IBOutlet weak var txtMensagem: UILabel!
    @IBOutlet weak var lblNomeUsuario: UILabel!
    @IBOutlet weak var imgFoto: UIImageView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
