//
//  ConversaTableViewController.swift
//  UFCMobile
//
//  Created by Renata on 08/06/2018.
//  Copyright © 2018 Renata. All rights reserved.
//

import UIKit

class ConversaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var cadeira = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mensagensTableView.register(UINib(nibName: "MensagensTableViewCell", bundle: nil), forCellReuseIdentifier: "mensagemCell")
       
    }
    
    func escreverMsg(){
        
    }
    
    func getCadeira(){
        
    }
    
    
    @IBOutlet weak var mensagensTableView: UITableView!
    
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
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mensagensTableView.dequeueReusableCell(withIdentifier: "mensagemCell", for: indexPath)
        return cell
    }
    

}
