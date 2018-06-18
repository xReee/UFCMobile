//
//  MensagensViewController.swift
//  UFCMobile
//
//  Created by Renata on 30/05/18.
//  Copyright © 2018 Renata. All rights reserved.
//

import UIKit
import Firebase

class MensagensViewController:  UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {

    var arrayCadeira: [Cadeira]? = [Cadeira]()
    let userID = Auth.auth().currentUser?.uid
    var ref: DatabaseReference!
    var idCelulaClicada : Cadeira!
    var collectionViewOpcaoAtiva = "Turmas"
    fileprivate var _refHandle: DatabaseHandle!
    var ultimasMensagens : [String:String]? = [String:String]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clvTipoMsg.register(UINib(nibName: "DiasCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "diasCVC")
        self.tbvMensagens.register(UINib(nibName: "ChatTableViewCell", bundle: nil), forCellReuseIdentifier: "chatCell")
        verificarDados()
        
    }
    
    //#MARK: verifica dados
    func verificarDados(){
        ref = Database.database().reference()
        arrayCadeira?.removeAll()
        ultimasMensagens?.removeAll()
        ref.child("users").child(userID!).child("cadeiras").observeSingleEvent(of: .value, with: { (snapshot) in
            if let cadeiras = snapshot.value as? NSDictionary {
                for i in cadeiras {
                    self.addCadeira(i.value as! String)
                }
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func addCadeira(_ cod : String){
        ref.child("cadeiras").child(cod).observeSingleEvent(of: .value, with: { (snapshot) in
            
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
            self.arrayCadeira?.append(novaCadeira)
            self.retornarUltimasMensagensDaCadeira(novaCadeira)
            self.tbvMensagens.reloadData()

        }) { (error) in
            print(error.localizedDescription)
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var clvTipoMsg: UICollectionView!
    @IBOutlet weak var tbvMensagens: UITableView!

    //#MARK: collectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
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
        collectionViewOpcaoAtiva = cell.lblDias.text!
        
        self.verificarDados()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(width: (self.view.frame.width / 2), height: collectionView.frame.size.height)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "diasCVC", for: indexPath) as! DiasCollectionViewCell
        if indexPath.row == 0 {
            cell.setActiveTo(true)
            cell.isSelected = true
            cell.lblDias.text = "Turmas"
        } else {
            cell.lblDias.text = "Professores"
        }
        
       
        return cell
    }
    
    //#MARK: table view
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let numeroCadeira = arrayCadeira?.count else {
            return 0
        }
        
        return numeroCadeira
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) as! ChatTableViewCell
        let nomeDaCadeiraDeAgora = arrayCadeira![indexPath.row].get("nome")
        cell.txtTitulo.text! = nomeDaCadeiraDeAgora
        if let ultimaMensagemDaCadeira = ultimasMensagens![nomeDaCadeiraDeAgora]{
            cell.txtUltimaMsg?.text! = ultimaMensagemDaCadeira
        } else {
            cell.txtUltimaMsg.text = " "
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        idCelulaClicada = arrayCadeira![indexPath.row]
        performSegue(withIdentifier: "goToConversa", sender: self)
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToConversa" {
            if let viewDestino = segue.destination as? ConversaViewController {
                viewDestino.cadeira = idCelulaClicada
                viewDestino.opcaoDeTexto = collectionViewOpcaoAtiva
            }
        }
        
    }
    
    func retornarUltimasMensagensDaCadeira(_ cadeira : Cadeira) {
        ref = Database.database().reference()
        // listen for new messages in the firebase database
            var mensagensCadeira = [Mensagem]()
            _refHandle = ref.child("mensages").child(cadeira.get("codigo")).child(collectionViewOpcaoAtiva).observe(DataEventType.value, with: { (snapshot) in
                if let idMensagens = snapshot.value as? NSDictionary {
                    for x in idMensagens {
                        var novaMensagem = Mensagem()
                        let mensagemInfo = x.value as? NSDictionary
                        for y in mensagemInfo! {
                            switch y.key as! String {
                            case "mensagem":
                                novaMensagem.mensagem = (y.value as? String)!
                                break
                            case "data":
                                novaMensagem.data = (y.value as? String)!
                                break
                            default: break
                            }
                        }
                        mensagensCadeira.append(novaMensagem)
                    }
                    mensagensCadeira.sort(by: { $0.data.compare($1.data) == .orderedAscending })
                    let ultimaMsg = mensagensCadeira.last!
                    let cadeiraAtual : Cadeira = cadeira
                    self.ultimasMensagens?[cadeiraAtual.get("nome")] = ultimaMsg.mensagem
                    self.tbvMensagens.reloadData()
                }
            }) { (error) in
                print(error.localizedDescription)
            }
            
       
    }
}
