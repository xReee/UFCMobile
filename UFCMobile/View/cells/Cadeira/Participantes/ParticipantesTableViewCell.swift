//
//  ParticipantesTableViewCell.swift
//  UFCMobile
//
//  Created by Renata on 18/06/2018.
//  Copyright © 2018 Renata. All rights reserved.
//

import UIKit

class ParticipantesTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var imgPerfil: UIImageView!
    @IBOutlet weak var txtNome: UILabel!
    @IBOutlet weak var txtCurso: UILabel!
    
}
