//
//  PerfilViewController.swift
//  UFCMobile
//
//  Created by Renata on 28/05/18.
//  Copyright © 2018 Renata. All rights reserved.
//

import UIKit

class PerfilViewController: BarraBrancaViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "perfilCell")
        cell?.textLabel?.text = opcoes[indexPath.row]
        return cell!
    }
    

    @IBOutlet weak var imgPerfil: UIImageView!
    @IBOutlet weak var btnEditar: UIButton!
    
    let opcoes = ["Perfil Completo", "Atestado de matrícula", "Cadeiras Anteriores", "IRA", "Resultado do processamento"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        setupViews()
    }
    
    func setupViews(){
        imgPerfil.layer.borderWidth = 10
        imgPerfil.layer.borderColor = UIColor.white.cgColor
        imgPerfil.layer.cornerRadius = (imgPerfil.frame.size.width / 2)
        
        btnEditar.layer.borderWidth = 1
        btnEditar.layer.borderColor = UIColor.white.cgColor
        btnEditar.layer.cornerRadius = btnEditar.frame.size.height / 2
    }
    
    

}
