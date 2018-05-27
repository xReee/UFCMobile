//
//  DiasCollectionViewCell.swift
//  UFCMobile
//
//  Created by Renata on 26/05/18.
//  Copyright © 2018 Renata. All rights reserved.
//

import UIKit

class DiasCollectionViewCell: UICollectionViewCell {

    
    
    func setActiveTo(_ status : Bool){
        if status {
            self.viewIsActive.isHidden = false
        } else {
            self.viewIsActive.isHidden = true
        }
    }
    
    func setLabelTo(_ labelName : String) {
        lblDias.text! = "\(labelName)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       
    }
    @IBOutlet weak var lblDias: UILabel!
    
    @IBOutlet weak var viewIsActive: UIView!
}
