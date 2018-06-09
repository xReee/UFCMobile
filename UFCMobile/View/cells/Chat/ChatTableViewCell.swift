//
//  ChatTableViewCell.swift
//  UFCMobile
//
//  Created by Renata on 31/05/18.
//  Copyright © 2018 Renata. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var imgFoto: UIImageView!
    @IBOutlet weak var updateView: UIView!
    @IBOutlet weak var txtTitulo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }

    func setupViews(){
        updateView.layer.cornerRadius = updateView.frame.size.width/2
        imgFoto.layer.cornerRadius = imgFoto.frame.size.width/2
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
