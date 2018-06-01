//
//  HomeViewController.swift
//  UFCMobile
//
//  Created by Renata on 26/05/18.
//  Copyright © 2018 Renata. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {
    
    var arrayCadeiras: [Cadeira]? = [Cadeira]()
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ref = Database.database().reference()
        verificarDados()
        
        self.diasCollectionView.register( UINib(nibName: "DiasCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "diasCVC")
        self.agendaTableView.register(UINib(nibName:"AgendaTableViewCell", bundle: nil ), forCellReuseIdentifier: "agendaCVC")
    }
    

    func verificarDados(){
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).child("cadeiras").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            
            
            let cadeiras = snapshot.value as? NSDictionary
            for i in cadeiras! {
                self.preencheCadeira(i.key as! String)
            }
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func preencheCadeira(_ cod : String){
        ref.child("cadeiras").child(cod).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            
            let cadeiraInfo = snapshot.value as? NSDictionary
            var local = String()
            var nome = String()
            var horarios = [String:[String:String]]()
            
            for i in cadeiraInfo! {
                
                
                switch i.key as! String {
                case "local":
                    local = i.value as! String
                    break
                case "nome":
                    nome = i.value as! String
                    break
                case"horario":
                    let dias = i.value as? NSDictionary
                    for y in dias! {
                        let dia = y.value as? NSDictionary
                        var fim = ""
                         var inicio = ""
                        for z in dia! {
                            switch z.key as! String {
                            case "inicio":
                                inicio = z.value as! String
                            default:
                                fim = z.value as! String
                            }
                        }
                        let horarioChave = y.key as! String
                        horarios[horarioChave] = [inicio:fim]
                    }
                    break
                default:
                    print("deu ruim")
                }
                
                
                
            }
            
            let novaCadeira = Cadeira(codigo: snapshot.key, nome: nome, local: local, horario: horarios)
            self.arrayCadeiras?.append(novaCadeira)
            self.agendaTableView.reloadData()
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // COLLECTION VIEW
            private let diasDaSemana = ["SEG","TER","QUA","QUI","SEX","SAB"]
    
            @IBOutlet weak var diasCollectionView: UICollectionView!
    
            func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                 let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "diasCVC", for: indexPath) as! DiasCollectionViewCell
                if indexPath.row == 0 {
                    cell.setActiveTo(true)
                    cell.isSelected = true
                }
                
                if indexPath.row <= diasDaSemana.count {
                    cell.setLabelTo(diasDaSemana[indexPath.row])
                }
                return cell
            }
    
            func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                //diseleciona todos
                for i in collectionView.visibleCells{
                    let cell = i as! DiasCollectionViewCell
                    cell.setActiveTo(false)
                }
                // seleciona o correto
                let cell = collectionView.cellForItem(at: indexPath) as! DiasCollectionViewCell
                    cell.setActiveTo(true)
            }
    
    
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                    let cellSize = CGSize(width: (self.view.frame.width / 6), height: collectionView.frame.size.height)
                return cellSize
            }
    
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
                return 0
            }
    
            func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                return 6
            }
    
    
     // TABLE VIEW
            @IBOutlet weak var agendaTableView: UITableView!
    
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                
                guard let qntCadeiras = self.arrayCadeiras?.count else {
                    return 0
                }
                return qntCadeiras
            }
    
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "agendaCVC") as! AgendaTableViewCell
                do {
                    let cadeiraDaVez : Cadeira = arrayCadeiras![indexPath.row] as! Cadeira
                    try cell.txtLocal.text! = cadeiraDaVez.get("local")
                    try cell.txtNome.text!  = cadeiraDaVez.get("nome")
                }
                return cell
            }
    
            func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                return 90
            }
    
    

}
