//
//  PerfilViewController.swift
//  UFCMobile
//
//  Created by Renata on 28/05/18.
//  Copyright © 2018 Renata. All rights reserved.
//

import UIKit
import Firebase

class PerfilViewController: BarraBrancaViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var txtMatricula: UILabel!
    @IBOutlet weak var txtNome: UILabel!
    @IBOutlet weak var indicadorDownload: UIActivityIndicatorView!
    
    var ref : DatabaseReference!
    let storage = Storage.storage()

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return opcoes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "perfilCell")
        cell?.textLabel?.text = opcoes[indexPath.row]
        return cell!
    }
    

    @IBOutlet weak var imgPerfil: UIImageView!
    @IBOutlet weak var btnEditar: UIButton!
    
  //  let opcoes = ["Perfil Completo", "Atestado de matrícula", "Cadeiras Anteriores", "IRA", "Resultado do processamento"]
    let opcoes = ["Perfil Completo"]// "Atestado de matrícula", "Cadeiras Anteriores", "IRA", "Resultado do processamento"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recuperarDados()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.indicadorDownload.isHidden = false
        recuperarDados()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        setupViews()
    }
    
    func setupViews(){
        imgPerfil.layer.borderWidth = 8
        imgPerfil.layer.borderColor = UIColor.white.cgColor
        imgPerfil.layer.cornerRadius = (imgPerfil.frame.size.width / 2)
        
        btnEditar.layer.borderWidth = 1
        btnEditar.layer.borderColor = UIColor.white.cgColor
        btnEditar.layer.cornerRadius = btnEditar.frame.size.height / 2
    }
    
    func recuperarDados(){
        ref = Database.database().reference()

        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let userInfo = snapshot.value as? NSDictionary

            for i in userInfo! {
                switch i.key as! String {
                case "matricula":
                    self.txtMatricula.text = "nº \(i.value)"
                    break
                case "nome":
                    self.txtNome.text = i.value as? String
                    break
                default:
                    break
                }
            }
            
            let storageRef = self.storage.reference().child("images/\(userID!)/profile.jpg")
            
            storageRef.downloadURL { (URL, error) -> Void in
                if (error != nil) {
                    // Handle any errors
                } else {
                    // Get the download URL for 'images/stars.jpg'
                    let data = NSData.init(contentsOf: URL!)
                    if data != nil {  //Some time Data value will be nil so we need to validate such things
                        self.imgPerfil.image = UIImage(data: data! as Data)
                        self.indicadorDownload.isHidden = true
                    }
                }
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    

}
