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
    var diaAtivo = "segunda"
    var horaAtiva = 0
    var diaAtual = "domingo"
    var lastIndice = 0
    let userID = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if  diaAtual != "domingo" {
            diaAtivo = diaAtual
        }
        
        self.agendaTableView.reloadData()

        self.diasCollectionView.register( UINib(nibName: "DiasCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "diasCVC")
        self.agendaTableView.register(UINib(nibName:"AgendaTableViewCell", bundle: nil ), forCellReuseIdentifier: "agendaCVC")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if  diaAtual != "domingo" {
            diaAtivo = diaAtual
        }
        configureDatabase()
    }
    
    func configureDatabase() {
        lastIndice = 0
        ref = Database.database().reference()
        verificarDados()
        self.agendaTableView.reloadData()
        
        
        
    }
    
    
    //# MARK: seleciona cadeira
    func selecionarPorDia(){
        
        let hora = Calendar.current.component(.hour, from: Date())
        let dia = Calendar.current.component(.weekday, from: Date())
        
        
        diaAtual = diasInteirosComDomingo[dia-1]
        if  diaAtual != "domingo" {
            diaAtivo = diaAtual
        }
        
        if dia != 1 {
            //diaAtivo = diasInteirosDaSemana[dia-2]
            horaAtiva = hora

            collectionView(diasCollectionView, didSelectItemAt: IndexPath.init(item: dia-2, section: 0))
        }
    
        //diaAtivo = diasInteirosDaSemana[0]
        
    }
    
    
    //#MARK: verifica dados
    func verificarDados(){
        
        arrayCadeiras?.removeAll()
     ref.child("users").child(userID!).child("cadeiras").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            
            
        if let cadeiras = snapshot.value as? NSDictionary {
            for i in cadeiras {
                self.preencheCadeira(i.key as! String)
            }
            
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
                        var inicio = String() //[String:String]()
                        var fim = String() //[String:String]()
                        for z in dia! {
                            switch z.key as! String {
                            case "inicio":
                                inicio = (z.value as? String)!
                            default:
                                fim = (z.value as? String)!
                                break
                            }
                        }
                        let horarioChave = y.key as! String
                        let arrayDeHorarios = ["inicio" : inicio  , "fim" : fim]
                        
                        horarios[horarioChave] = arrayDeHorarios
                        
                    }
                    break
                default:
                    //professor é o que falta
                    break
                }               
            }
            
            let novaCadeira = Cadeira(codigo: snapshot.key, nome: nome, local: local, horario: horarios)
            self.arrayCadeiras?.append(novaCadeira)
            self.selecionarPorDia()

            self.agendaTableView.reloadData()
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //#MARK: COLLECTION VIEW
            private let diasDaSemana = ["SEG","TER","QUA","QUI","SEX","SAB"]
            private let diasInteirosDaSemana = ["segunda","terca","quarta","quinta","sexta","sabado"]
            private let diasInteirosComDomingo = ["domingo", "segunda","terca","quarta","quinta","sexta","sabado"]

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
                lastIndice = 0
                
                //diseleciona todos
                for i in collectionView.visibleCells{
                    let cell = i as! DiasCollectionViewCell
                    cell.setActiveTo(false)
                }
                
                // seleciona o correto
                let cell = collectionView.cellForItem(at: indexPath) as! DiasCollectionViewCell
                cell.setActiveTo(true)
                diaAtivo = diasInteirosDaSemana[indexPath.row]
                
                self.agendaTableView.reloadData()
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
    
    
     //#MARK: TABLE VIEW
            @IBOutlet weak var agendaTableView: UITableView!
    
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                
                guard let qntCadeiras = self.arrayCadeiras?.count else {
                    return 0
                }
                var contador = 0

                if qntCadeiras > 0 {
                    for i in 0...qntCadeiras - 1 {
                        let cadeiraDaVez = arrayCadeiras![i]
                        if cadeiraDaVez.getHorarioInicio(dia: diaAtivo) != "" {
                            contador+=1
                        }
                    }
                }
                return contador
            }
    
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "agendaCVC") as! AgendaTableViewCell

                guard let qntCadeiras = self.arrayCadeiras?.count else {
                    return cell
                }
                
                    for i in lastIndice...qntCadeiras - 1 {
                        let cadeiraDaVez = arrayCadeiras![i]
                        if cadeiraDaVez.getHorarioInicio(dia: diaAtivo) != "" {
                                let cadeira : Cadeira = arrayCadeiras![i]
                                cell.txtLocal.text! = cadeira.get("local")
                                cell.txtNome.text!  = cadeira.get("nome")
                                cell.txtHora.text! = cadeira.getHorarioInicio(dia: diaAtivo)
                                cell.txtTurno.text! = cadeira.getTurno()
                            if (horaAtiva >=  cadeira.getHorarioInt(dia: diaAtivo, "inicio")) && (horaAtiva <= cadeira.getHorarioInt(dia: diaAtivo, "fim") && diaAtivo == diaAtual) {
                                cell.selecionarCelula()
                            } else {
                                cell.deselecionarCelula()
                            }
                            lastIndice = i+1
                            return cell
                         }
                        }
                return cell
                
            }
    
            func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                return 90
            }
    
    

}
