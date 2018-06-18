//
//  CadeiraTableViewController.swift
//  UFCMobile
//
//  Created by Renata on 17/06/2018.
//  Copyright © 2018 Renata. All rights reserved.
//

import UIKit

class CadeiraTableViewController: UITableViewController {

    var codCadeira = ""
    var opcao = ""
    var opcaoAtiva = ""
    var opcoesTableView = ["Frequencia","Arquivos","Tarefas","Nota de Avaliações","Participantes"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = opcao
        self.navigationItem.largeTitleDisplayMode = .never
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return opcoesTableView.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cadeiraCell", for: indexPath)

         cell.textLabel?.text = opcoesTableView[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.opcaoAtiva = (tableView.cellForRow(at: indexPath)?.textLabel?.text!)!
        performSegue(withIdentifier: "gotoDetalheDaCadeira", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoDetalheDaCadeira" {
            let vc = segue.destination as! DetalheCadeiraTableViewController
            vc.opcao = self.opcaoAtiva
            vc.codCadeira = self.codCadeira
        }
    }
    
}
