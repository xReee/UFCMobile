//
//  DetalheCadeiraTableViewController.swift
//  UFCMobile
//
//  Created by Renata on 17/06/2018.
//  Copyright © 2018 Renata. All rights reserved.
//

import UIKit
import Firebase

class DetalheCadeiraTableViewController: UITableViewController {

    var opcao = ""
    var codCadeira = ""
    var trabalhos = [String:String]()
    var nomeTrabalhos = [String]()
    var ref: DatabaseReference!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = opcao
        self.tableView.register(UINib(nibName: "ArquivosTableViewCell", bundle: nil), forCellReuseIdentifier: "arquivoCell")
        retornaCadeira()
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
        // #warning Incomplete implementation, return the number of rows
        return self.nomeTrabalhos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "arquivoCell", for: indexPath) as! ArquivosTableViewCell
            cell.txtNome.text = self.nomeTrabalhos[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let arquivo = trabalhos[self.nomeTrabalhos[indexPath.row]] {
            if let url = URL(string: arquivo) {
                UIApplication.shared.open(url)
            }
        }
    }
    
    func retornaCadeira(){
        ref = Database.database().reference()

        ref.child("cadeiras").observeSingleEvent(of: .value, with: { (snapshot) in
            for cadeira in snapshot.value as! NSDictionary{
                if cadeira.key as! String == self.codCadeira {
                    for dadosCadeira in cadeira.value as! NSDictionary {
                        if dadosCadeira.key as! String == "arquivos" {
                            for arquivos in dadosCadeira.value as! NSDictionary {
                                let arquivoNome = arquivos.key as! String
                                let arquivoURL = arquivos.value as! String
                                self.trabalhos[arquivoNome] = arquivoURL
                                self.nomeTrabalhos.append(arquivoNome)
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        })
    }

}
