//
//  HomeViewController.swift
//  UFCMobile
//
//  Created by Renata on 26/05/18.
//  Copyright © 2018 Renata. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.diasCollectionView.register( UINib(nibName: "DiasCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "diasCVC")
        self.agendaTableView.register(UINib(nibName:"AgendaTableViewCell", bundle: nil ), forCellReuseIdentifier: "agendaCVC")
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
                return 4
            }
    
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "agendaCVC") as! AgendaTableViewCell
                return cell
            }
    
            func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                return 90
            }
    
    

}
