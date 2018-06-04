    //
//  EditarPerfilViewController.swift
//  UFCMobile
//
//  Created by Renata on 03/06/18.
//  Copyright © 2018 Renata. All rights reserved.
//

import UIKit
import Firebase

class EditarPerfilViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var ref : DatabaseReference!
    let userID = Auth.auth().currentUser?.uid

    var dados = [String: String]()
    
    @IBOutlet weak var imgPerfil: UIImageView!
    let imagePicker = UIImagePickerController()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dados.count
    }
    @IBAction func btnCancelar(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnConfirmar(_ sender: UIButton) {
       // self.ref.child("users").child(userID!).setValue(["nascimento": "10/10/01"])
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnFoto(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate =  self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = opcoesTableView.dequeueReusableCell(withIdentifier: "opCell") as! EditarTableViewCell
        switch indexPath.row {
        case 0:
            cell.txtOpcaoNome.text! = "Nome: "
            cell.txtField.text! = dados["nome"]!
        case 1:
            cell.txtOpcaoNome.text! = "Sexo: "
            cell.txtField.text! = dados["sexo"]!
        case 2:
            cell.txtOpcaoNome.text! = "Data de Nascimento: "
            cell.txtField.text! = dados["nascimento"]!
        default:
            cell.txtOpcaoNome.text! = "nada"
            cell.txtField.text! = "nada"
        }
        
        
       
        
        return cell
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imgPerfil.image = image

        }
    }
    
    
    @IBOutlet weak var opcoesTableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recuperarDados()
        opcoesTableView.register(UINib(nibName: "EditarTableViewCell", bundle: nil), forCellReuseIdentifier: "opCell")
        opcoesTableView.becomeFirstResponderTextField()
    }

    
    override func viewDidLayoutSubviews() {
        imgPerfil.layer.borderWidth = 5
        imgPerfil.layer.borderColor = UIColor.white.cgColor
        imgPerfil.layer.cornerRadius = (imgPerfil.frame.size.height / 2)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func grcTapOut(_ sender: UITapGestureRecognizer) {
         opcoesTableView.becomeFirstResponderTextField()
    }
    
    
    func recuperarDados(){
        ref = Database.database().reference()
        
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let userInfo = snapshot.value as? NSDictionary
            
            for i in userInfo! {
                switch i.key as! String {
                case "nome":
                    self.dados["nome"] =  i.value as? String
                    break
                case "nascimento":
                    self.dados["nascimento"] =  i.value as? String
                    break
                case "sexo":
                    self.dados["sexo"] =  i.value as? String
                    break
                default:
                    break
                }
            }
              self.opcoesTableView.reloadData()
            
        }) { (error) in
            print(error.localizedDescription)
        }
     
      
    }

    
}
