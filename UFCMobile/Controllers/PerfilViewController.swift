//
//  PerfilViewController.swift
//  UFCMobile
//
//  Created by Renata on 28/05/18.
//  Copyright © 2018 Renata. All rights reserved.
//

import UIKit

class PerfilViewController: BarraBrancaViewController {

    @IBOutlet weak var imgPerfil: UIImageView!
    @IBOutlet weak var btnEditar: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupViews(){
        imgPerfil.layer.borderWidth = 10
        imgPerfil.layer.borderColor = UIColor.white.cgColor
        imgPerfil.layer.cornerRadius = (imgPerfil.frame.size.width / 1.7)
        
        btnEditar.layer.borderWidth = 5
        btnEditar.layer.borderColor = UIColor.white.cgColor
        btnEditar.layer.cornerRadius = btnEditar.frame.size.height / 3
    }
    
    

}
