//
//  ConversaTableViewController.swift
//  UFCMobile
//
//  Created by Renata on 08/06/2018.
//  Copyright © 2018 Renata. All rights reserved.
//

import UIKit
import Firebase

class ConversaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var cadeira : Cadeira!
    var mensagens: [DataSnapshot]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mensagensTableView.register(UINib(nibName: "MensagensTableViewCell", bundle: nil), forCellReuseIdentifier: "mensagemCell")
        txfMsg.delegate = self

    }
    
    override func viewDidLayoutSubviews() {
        self.navigationItem.title = cadeira?.get("nome")
    }
    
    func escreverMsg(){
        
    }
    
    //#MARK: OUTLETS
    
    @IBOutlet weak var txfMsg: UITextField!
    
    @IBOutlet weak var mensagensTableView: UITableView!
    
    @IBAction func btnEnviar(_ sender: Any) {
    }
    
    @IBAction func didBeganMsg(_ sender: UITextField) {
        moveTextField(sender, moveDistance: 200, up: false)
    }
    
    @IBAction func didEndMsg(_ sender: UITextField) {
        moveTextField(sender, moveDistance: 200, up: true)
    }
    
    @IBAction func tapped(_ sender: Any) {
         txfMsg.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mensagens.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mensagensTableView.dequeueReusableCell(withIdentifier: "mensagemCell", for: indexPath)
        
        return cell
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return  true
    }
    

}
