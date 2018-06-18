//
//  ViewController.swift
//  UFCMobile
//
//  Created by Renata on 07/05/18.
//  Copyright © 2018 Renata. All rights reserved.
//

import UIKit
import Firebase
import JSSAlertView


class LoginController: UIViewController, UITextFieldDelegate {

    var ref : DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtMatricula.delegate = self
        txtSenha.delegate = self
        
        ref = Database.database().reference()
    }
    
    override func viewDidLayoutSubviews() {
        btnAcessarOutlet.layer.cornerRadius = (btnAcessarOutlet.frame.size.height / 2)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        txtMatricula.text = ""
        txtSenha.text = ""
    }

    @IBAction func btnLogar(_ sender: UIButton) {
        //performSegue(withIdentifier: "gotoLogar", sender: nil)
        var encontrou = false
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in

            guard let users = snapshot.value as? NSDictionary else {
                return
            }
            
            encontrou = false
            
            for i in users{
                let conteudoUser = i.value as? NSDictionary
                let matricula = conteudoUser!["matricula"] as? String
                if self.txtMatricula.text == matricula && !self.txtSenha.isEqual("") {
                    encontrou = true
                    let email = conteudoUser!["emailAuth"] as? String
                    Auth.auth().signIn(withEmail: email!, password: self.txtSenha.text!) { (user, error) in
                        if (error == nil) {
                            self.sairDoTeclado()
                            self.performSegue(withIdentifier: "gotoLogar", sender: nil)
                        } else {
                            JSSAlertView().success(
                                self, // the parent view controller of the alert
                                title: "Senha inválida",
                                text: "Por favor verifique os campos")
                        }
                    }
                }
            }
            
            if encontrou == false{
                JSSAlertView().success(
                    self, // the parent view controller of the alert
                    title: "Erro de autenticação",
                    text: "Por favor verifique os campos")
            }
            
        }) { (error) in
            //print(error.localizedDescription)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var txtMatricula : UITextField!
    @IBOutlet weak var txtSenha : UITextField!
    
    @IBAction func grcTapOut(_ sender: UITapGestureRecognizer) {
       sairDoTeclado()
    }
    
    @IBAction func didBeganSenha(_ sender: UITextField) {
        moveTextField(sender, moveDistance: Int(self.view.frame.height/5) , up: false)
    }
    
    @IBAction func didEndSenha(_ sender: UITextField) {
        moveTextField(sender, moveDistance: Int(self.view.frame.height/5) , up: true)
    }
    
    @IBAction func didBeganMatricula(_ sender: UITextField) {
        moveTextField(sender, moveDistance: Int(self.view.frame.height/6) , up: false)
    }
    
    @IBAction func didEndMatricula(_ sender: UITextField) {
        moveTextField(sender, moveDistance: Int(self.view.frame.height/6) , up: true)
    }
    @IBOutlet weak var btnAcessarOutlet: UIButton!
    
    func sairDoTeclado(){
        txtMatricula.resignFirstResponder()
        txtSenha.resignFirstResponder()
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return  true
    }
    
}

