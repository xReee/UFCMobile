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
    
    
    //#MARK: OUTLETS
    @IBOutlet weak var txfNome: UITextField!
    @IBOutlet weak var imgPerfil: UIImageView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var segSexo: UISegmentedControl!
    
    let imagePicker = UIImagePickerController()

    @IBAction func btnCancelar(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnFoto(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate =  self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func btnConfirmar(_ sender: UIButton) {

        if (txfNome.text?.isEmpty)! {
            JSSAlertView().success(
                self, // the parent view controller of the alert
                title: "Erro!",
                text: "Por favor verifique se esqueceu de inserir dados em algum dos campos")
        } else {
            ref.child("users").child(userID!).updateChildValues(["nome": self.txfNome.text!])
            
            if (txtEmail.text?.isEmpty)! {
                ref.child("users").child(userID!).updateChildValues(["email": ""])
            } else {
                ref.child("users").child(userID!).updateChildValues(["email": self.txtEmail.text!])
            }
            let sexo =  self.segSexo.selectedSegmentIndex
            switch sexo {
            case 0:
                ref.child("users").child(userID!).updateChildValues(["sexo": "M"])
                break
            case 1:
                ref.child("users").child(userID!).updateChildValues(["sexo": "F"])
                break
            default:
                ref.child("users").child(userID!).updateChildValues(["sexo": "-"])
                break
            }
            
            
            self.dismiss(animated: true, completion: nil)
            
        }
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
        txtEmail.delegate = self
        txfNome.delegate = self
        
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
        txtEmail.resignFirstResponder()
        txfNome.resignFirstResponder()
    }
    
    //nome
    @IBAction func txtNomedDidBegin(_ sender: UITextField) {
        moveTextField(sender, moveDistance: Int(self.viewSize("height")/6) , up: false)
    }
    @IBAction func txtNomedDidEnd(_ sender: UITextField) {
        sender.resignFirstResponder()
        moveTextField(sender, moveDistance: Int(self.viewSize("height")/6) , up: true)
    }
    
    //email
    @IBAction func txtEmailDidBegin(_ sender: UITextField) {
        moveTextField(sender, moveDistance: Int(self.viewSize("height")/6) , up: false)
    }
    @IBAction func txtEmaildDidEnd(_ sender: UITextField) {
        sender.resignFirstResponder()
        moveTextField(sender, moveDistance: Int(self.viewSize("height")/6) , up: true)
    }
    func recuperarDados(){
        ref = Database.database().reference()
        
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let userInfo = snapshot.value as? NSDictionary
            
            for i in userInfo! {
                switch i.key as! String {
                case "nome":
                    self.txfNome.text! = (i.value as? String)!
                    break
                case "nascimento":
                    //self.dados["nascimento"] =  i.value as? String
                    break
                case "sexo":
                    let sexo =  i.value as? String
                    switch sexo {
                    case "F":
                        self.segSexo.selectedSegmentIndex = 1
                            break
                    case "M":
                        self.segSexo.selectedSegmentIndex = 0
                        break
                    default:
                        self.segSexo.selectedSegmentIndex = 2
                        break
                    }
                    break
                case "email":
                    self.txtEmail.text! = (i.value as? String)!
                    break
                default:
                    break
                }
            }
                
        }) { (error) in
            print(error.localizedDescription)
        }
     
      
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return  true
    }
}
