//
//  EditarTableViewCell.swift
//  UFCMobile
//
//  Created by Renata on 03/06/18.
//  Copyright © 2018 Renata. All rights reserved.
//

import UIKit

class EditarTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBOutlet weak var txtOpcaoNome: UILabel!
    @IBOutlet weak var txtField: UITextField!
    
    @IBAction func didEndOpcao(_ sender: UITextField) {
       sender.resignFirstResponder()
    }
    
    
}
