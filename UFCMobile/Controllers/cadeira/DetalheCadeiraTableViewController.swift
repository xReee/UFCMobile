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
    var objetos = [String:String]()
    var nomeDosObjetos = [String]()
    var nomeOutrasOp = [String]()
    var ref: DatabaseReference!
    let userID = Auth.auth().currentUser?.uid


    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = opcao
        //    var opcoesTableView = ["Frequencia","Arquivos","Tarefas","Nota de Avaliações","Participantes"]

        if opcao == "Arquivos" {
            self.tableView.register(UINib(nibName: "ArquivosTableViewCell", bundle: nil), forCellReuseIdentifier: "arquivoCell")
            retornaCoisasDaCadeira("arquivos")
        } else if opcao == "Tarefas" {
            self.tableView.register(UINib(nibName: "CadeiraTableViewCell", bundle: nil), forCellReuseIdentifier: "opcoesCell")
            retornaCoisasDaCadeira("tarefas")
        } else if opcao == "Nota de Avaliações" {
            self.tableView.register(UINib(nibName: "CadeiraTableViewCell", bundle: nil), forCellReuseIdentifier: "opcoesCell")
            retornarCoisasDoAluno("notas")
        } else if opcao == "Frequencia" {
            self.tableView.register(UINib(nibName: "CadeiraTableViewCell", bundle: nil), forCellReuseIdentifier: "opcoesCell")
            retornarCoisasDoAluno("frequencia")
        }
        
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
        return self.nomeDosObjetos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if opcao == "Arquivos" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "arquivoCell", for: indexPath) as! ArquivosTableViewCell
            cell.txtNome.text = self.nomeDosObjetos[indexPath.row]
            return cell
        } else if opcao != "Participantes" && opcao != "Nota de Avaliações" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "opcoesCell", for: indexPath) as! CadeiraTableViewCell
            
            cell.txtNome.text = self.nomeDosObjetos[indexPath.row]
            cell.txtEstado.text = self.objetos[self.nomeDosObjetos[indexPath.row]]
            switch cell.txtEstado.text! {
            case "Não enviada", "Ausente":
                cell.txtEstado.textColor = .red
                break
            case "Entregue", "Presente":
                cell.txtEstado.textColor = UIColor.verdePrincipal()
                break
            default:
                cell.txtEstado.textColor = .orange
                break
            }
            return cell
        } else if opcao == "Nota de Avaliações" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "opcoesCell", for: indexPath) as! CadeiraTableViewCell
            cell.txtNome.text = self.nomeDosObjetos[indexPath.row]
            cell.txtEstado.text = self.objetos[self.nomeDosObjetos[indexPath.row]]
            return cell
        }
        
        let cell = UITableViewCell()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if opcao == "Arquivos" {
            if let arquivo = objetos[self.nomeDosObjetos[indexPath.row]] {
                if let url = URL(string: arquivo) {
                    UIApplication.shared.open(url)
                }
            }
        }
    }
    
 
    func retornaCoisasDaCadeira(_ oqEhPraRetornar : String){
        ref = Database.database().reference()

        ref.child("cadeiras").observeSingleEvent(of: .value, with: { (snapshot) in
            for cadeira in snapshot.value as! NSDictionary{
                if cadeira.key as! String == self.codCadeira {
                    for dadosCadeira in cadeira.value as! NSDictionary {
                        if dadosCadeira.key as! String == oqEhPraRetornar {
                                for objetos in dadosCadeira.value as! NSDictionary {
                                    let objetoNome = objetos.key as! String
                                    let objetoDetalhe = objetos.value as! String
                                    self.objetos[objetoNome] = objetoDetalhe
                                    self.nomeDosObjetos.append(objetoNome)
                                    self.tableView.reloadData()
                                } //for
                            }
                        }
                    }
                }
        })
        
    }
    
    func retornarCoisasDoAluno(_ oqEhPraRetornar : String){
        ref = Database.database().reference()

        ref.child("users").child(userID!).child("cadeiras").child(codCadeira).observeSingleEvent(of: .value, with: { (snapshot) in
            for dado in snapshot.value as! NSDictionary{
               if dado.key as! String == oqEhPraRetornar {
                for objetos in dado.value as! NSDictionary {
                        let objetoNome = objetos.key as! String
                        let objetoDetalhe = objetos.value as! String
                        self.objetos[objetoNome] = objetoDetalhe
                        self.nomeDosObjetos.append(objetoNome)
                        self.tableView.reloadData()
                    } //for
               }
            }
        })
        
    }
    
    
}//fim da classe
