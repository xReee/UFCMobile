//
//  ViewController.swift
//  UFCMobile
//
//  Created by Renata on 07/05/18.
//  Copyright © 2018 Renata. All rights reserved.
//

import UIKit

class LoginController: UIViewController, UITextFieldDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtMatricula.delegate = self
        txtSenha.delegate = self

    }

    @IBAction func btnLogar(_ sender: UIButton) {
        performSegue(withIdentifier: "gotoLogar", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var txtMatricula : UITextField!
    @IBOutlet weak var txtSenha : UITextField!
    
    @IBAction func grcTapOut(_ sender: UITapGestureRecognizer) {
        txtMatricula.resignFirstResponder()
        txtSenha.resignFirstResponder()
    }
    
    @IBAction func didBeganSenha(_ sender: UITextField) {
        moveTextField(sender, moveDistance: 35, up: false)
    }
    
    @IBAction func didEndSenha(_ sender: UITextField) {
        moveTextField(sender, moveDistance: 35, up: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return  true
    }
    
}

