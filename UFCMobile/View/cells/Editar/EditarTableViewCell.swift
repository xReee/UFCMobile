//
//  EditarTableViewCell.swift
//  UFCMobile
//
//  Created by Renata on 03/06/18.
//  Copyright © 2018 Renata. All rights reserved.
//

import UIKit

class EditarTableViewCell: UITableViewCell, UITextFieldDelegate {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    @IBAction func didBegin(_ sender: UITextField) {
        
    }
    
    
    @IBAction func didFinish(_ sender: UITextField!) {
        sender.resignFirstResponder();
    }
    @IBOutlet weak var txtOpcaoNome: UILabel!
    @IBOutlet weak var txtField: UITextField!
    
}
