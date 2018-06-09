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

    var arrayCadeira: [String]? = [String]()
    let userID = Auth.auth().currentUser?.uid
    var ref: DatabaseReference!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clvTipoMsg.register(UINib(nibName: "DiasCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "diasCVC")
        self.tbvMensagens.register(UINib(nibName: "ChatTableViewCell", bundle: nil), forCellReuseIdentifier: "chatCell")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        verificarDados()
       // tbvMensagens.reloadData()
    }
    
    //#MARK: verifica dados
    func verificarDados(){
        ref = Database.database().reference()
        arrayCadeira?.removeAll()
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
            if let cadeiraInfo = snapshot.value as? NSDictionary {
                for i in cadeiraInfo {
                    if (i.key as! String) == "nome" {
                        self.arrayCadeira?.append(i.value as! String)
                    }
                }
            }

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
        cell.txtTitulo.text! = arrayCadeira![indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}
