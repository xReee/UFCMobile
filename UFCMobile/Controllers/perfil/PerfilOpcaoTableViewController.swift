//
//  PerfilOpcaoTableViewController.swift
//  UFCMobile
//
//  Created by Renata on 16/06/2018.
//  Copyright © 2018 Renata. All rights reserved.
//

import UIKit
import Firebase

class PerfilOpcaoTableViewController: UITableViewController {

    var opcaoEscolhida = ""
    lazy var opcoes = [String]()
    var ref : DatabaseReference!
    let userID = Auth.auth().currentUser?.uid
    var dados = [String: String]()
    var opcaoAtiva = ""
    var codigo = ""
    
    @IBAction func btnVoltar(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent

        
        self.navigationItem.title = opcaoEscolhida
        self.tableView.register(UINib.init(nibName: "OpcoesTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")

        if opcaoEscolhida == "Perfil Completo" {
            opcoes =  ["Nome","Matricula", "Curso", "Semestre", "IRA", "Nascimento", "Sexo", "Email" ]
            recuperarDadosUsuario()
            
        } else {
            recuperarDadosCadeira()
        }
        
    }

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
        
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
        return dados.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OpcoesTableViewCell
        cell.selectionStyle = .none
        
        cell.txtOpNome.text = opcoes[indexPath.row]
                guard let valorOpcao = dados[opcoes[indexPath.row]] else {
                    cell.txtOpValor.text = "Não informado"
                    return cell
            }
        if valorOpcao == "" {
            cell.txtOpValor.text = "Não informado"
            return cell
        }
        
        cell.txtOpValor.text = valorOpcao
            return cell
        
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func recuperarDadosCadeira(){
        ref = Database.database().reference()
        ref.child("users").child(userID!).child("cadeiras").observeSingleEvent(of: .value, with: { (snapshot) in
            let cadeirasInfo = snapshot.value as? NSDictionary
            for i in cadeirasInfo! {
                self.opcoes.append(i.key as! String)
                self.recuperarCadeira(i.key as! String)
                
            }
        })
    }
    
    func recuperarCadeira(_ cadeira : String){
        ref.child("cadeiras").child(cadeira).observeSingleEvent(of: .value, with: { (snapshot) in
            let cadeirasInfo = snapshot.value as? NSDictionary
            for i in cadeirasInfo! {
                if i.key as! String == "nome" {
                    self.dados[cadeira] = i.value as? String
                    self.tableView.reloadData()
                    break
                }
            }
        })
    }
    
    func recuperarDadosUsuario(){
        ref = Database.database().reference()
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let userInfo = snapshot.value as? NSDictionary
            
            for i in userInfo! {
                let op = i.key as! String
                switch op {
                    case "nome":
                        self.dados["Nome"] = i.value as? String
                    break
                    case "nascimento":
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss Z"
                        dateFormatter.isLenient = true
                        if let nascimento = dateFormatter.date(from: (i.value as? String)!){
                            dateFormatter.dateFormat = "dd/MM/yyyy"
                            self.dados["Nascimento"] = dateFormatter.string(from: nascimento)
                        }
                        break
                    case "sexo":
                        let sexo =  i.value as? String
                        switch sexo {
                        case "F":
                            self.dados["Sexo"] = "Feminino"
                            break
                        case "M":
                            self.dados["Sexo"] = "Masculino"
                            break
                        default:
                            self.dados["Sexo"] = "Não informado"
                            break
                        }
                        break
                    
                    case "email":
                       self.dados["Email"] = i.value as? String
                    break

                    case "curso":
                        self.dados["Curso"] = i.value as? String
                    break

                    case "matricula":
                        self.dados["Matricula"] = i.value as? String
                    break

                    case "semestre":
                        self.dados["Semestre"] = i.value as? String
                    break
                    
                    case "IRA":
                        self.dados["IRA"] = i.value as? String
                    break

                    
                    default:
                        break
                    
                }
                
            }
            self.tableView.reloadData()
            
        }) { (error) in
            //Error occured
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       if opcaoEscolhida != "Perfil Completo" {
        let cell = tableView.cellForRow(at: indexPath) as! OpcoesTableViewCell
        self.opcaoAtiva = cell.txtOpValor.text!
        self.codigo = cell.txtOpNome.text!
            performSegue(withIdentifier: "gotoCadeiraByPerfil", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoCadeiraByPerfil"{
            let viewDestino = segue.destination as! CadeiraTableViewController
            viewDestino.opcao = self.opcaoAtiva
            viewDestino.codCadeira = self.codigo
        }
    }

}
