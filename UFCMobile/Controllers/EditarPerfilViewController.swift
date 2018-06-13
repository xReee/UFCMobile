    //
//  EditarPerfilViewController.swift
//  UFCMobile
//
//  Created by Renata on 03/06/18.
//  Copyright © 2018 Renata. All rights reserved.
//

import UIKit
import Firebase
import JSSAlertView
    
class EditarPerfilViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var ref : DatabaseReference!
    let userID = Auth.auth().currentUser?.uid

    var dados = [String: String]()
    
    @IBOutlet weak var txfNome: UITextField!
    @IBOutlet weak var imgPerfil: UIImageView!
    let imagePicker = UIImagePickerController()

    @IBAction func btnCancelar(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnConfirmar(_ sender: UIButton) {

        if (txfNome.text?.isEmpty)! {
            JSSAlertView().success(
                self, // the parent view controller of the alert
                title: "Erro!",
                text: "Por favor verifique se esqueceu de inserir dados em algum dos campos")
        } else {

        ref.child("users").child(userID!).updateChildValues(["nome": self.txfNome.text!])

//        let key = ref.child("users").child(userID)().key
//        let perfil = ["nascimento": txt,
//                    "nome": title,
//                    "sexo": body]
//        let childUpdates = ["/user/\(key)": post,
//                            "/user-posts/\(userID)/\(key)/": post]
//        ref.updateChildValues(childUpdates)
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    @IBAction func btnFoto(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate =  self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imgPerfil.image = image

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recuperarDados()
        
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
//         opcoesTableView.becomeFirstResponderTextField()
    }
    
    
    func recuperarDados(){
        ref = Database.database().reference()
        
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let userInfo = snapshot.value as? NSDictionary
            
            for i in userInfo! {
                switch i.key as! String {
                case "nome":
//                    self.dados["nome"] =  i.value as? String
                    self.txfNome.text! = (i.value as? String)!
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
                
        }) { (error) in
            print(error.localizedDescription)
        }
     
      
    }

    
}
