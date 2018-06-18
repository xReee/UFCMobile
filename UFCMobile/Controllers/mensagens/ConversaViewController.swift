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
    
    var users = [String:String]()
    var cadeira : Cadeira!
    var opcaoDeTexto : String!
    var mensagens : [Mensagem]! = []
    var ref : DatabaseReference!
    let storage = Storage.storage()
    let userID = Auth.auth().currentUser?.uid
    var msglength: NSNumber = 1000
    fileprivate var _refHandle: DatabaseHandle!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        configureDatabase()
        mensagensTableView.register(UINib(nibName: "MensagensTableViewCell", bundle: nil), forCellReuseIdentifier: "mensagemCell")
        txfMsg.delegate = self

    }
    
    override func viewDidLayoutSubviews() {
        self.navigationItem.title = cadeira?.get("nome")
    }
    
    
    func usernameBy(id: String) -> String {
        if id == userID {return "Você"}
        if let result = users[id] {
            return result
        }
        return ""
    }
    
    func populateUsers(){
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            for i in (snapshot.value as? NSDictionary)! {
                for y in (i.value as? NSDictionary)! {
                    if (y.key as? String) == "nome" {
                       self.users[(i.key as! String)] = (y.value as! String)
                    }
                }
            }
            self.mensagensTableView.reloadData()
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    func configureDatabase() {
        ref = Database.database().reference()
        
        //first return everyone
        populateUsers()
        
        // listen for new messages in the firebase database
        _refHandle = ref.child("mensages").child(cadeira.get("codigo")).child(opcaoDeTexto).observe(DataEventType.value, with: { (snapshot) in
           self.mensagens.removeAll()
            if let idMensagens = snapshot.value as? NSDictionary {
                for x in idMensagens {
                    let mensagemInfo = x.value as? NSDictionary
                    var novaMensagem = Mensagem()
                    for y in mensagemInfo! {
                        switch y.key as! String {
                        case "autor":
                            novaMensagem.autor = (y.value as? String)!
                            break;
                        case "data":
                            novaMensagem.data = (y.value as? String)!
                            break;
                        case "mensagem":
                            novaMensagem.mensagem = (y.value as? String)!
                            break;
                        default: break
                            
                        }
                    }
                    
                    self.mensagens.append(novaMensagem)
                    
                }
                
                self.ordenarMensagens()
                self.mensagensTableView.reloadData()
                self.scrollToBottomMessage()
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    //#MARK: Scroll
    func scrollToBottomMessage() {
        if mensagens.count == 0 { return }
        let bottomMessageIndex = IndexPath(row: mensagensTableView.numberOfRows(inSection: 0) - 1, section: 0)
        mensagensTableView.scrollToRow(at: bottomMessageIndex, at: .bottom, animated: true)
    }
    
    deinit {
       ref.child("mensages").child(cadeira.get("codigo")).child(opcaoDeTexto).removeObserver(withHandle: _refHandle)
    }
    
    //#MARK: ordenar Mensagens
    func ordenarMensagens(){
        mensagens.sort(by: { $0.data.compare($1.data) == .orderedAscending })
    }
    
    
    //#MARK: OUTLETS
    
    @IBOutlet weak var txfMsg: UITextField!
    
    @IBOutlet weak var mensagensTableView: UITableView!
    
    @IBAction func btnEnviar(_ sender: Any) {
        if !txfMsg.text!.isEmpty {
            var conteudoMensagem = [String:String]()
            conteudoMensagem["mensagem"] = txfMsg.text!
            conteudoMensagem["autor"] = userID
            
            //para data
            let date = Date()
            conteudoMensagem["data"] = "\(date)"
            
            
            
            conteudoMensagem["data"] = "\(date)"
            
            self.ref.child("mensages").child(self.cadeira.get("codigo")).child(self.opcaoDeTexto).childByAutoId().setValue(conteudoMensagem)
            txfMsg.resignFirstResponder()
            txfMsg.text! = ""

        }
        
    }
    
    @IBAction func didBeganMsg(_ sender: UITextField) {
        moveTextField(sender, moveDistance: 210, up: false)
    }
    
    @IBAction func didEndMsg(_ sender: UITextField) {
        moveTextField(sender, moveDistance: 210, up: true)
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if mensagens.count > 0{
            return mensagens.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mensagensTableView.dequeueReusableCell(withIdentifier: "mensagemCell", for: indexPath) as! MensagensTableViewCell
        let mensagemAtual = mensagens[indexPath.row]
        cell.lblNomeUsuario.text! = self.usernameBy(id: mensagemAtual.autor)
        cell.txtMensagem.text! = mensagemAtual.mensagem
        return cell
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return  true
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // set the maximum length of the message
        guard let text = txfMsg.text else { return true }
        let newLength = text.utf16.count + string.utf16.count - range.length
        return newLength <= msglength.intValue
    }
    

}
