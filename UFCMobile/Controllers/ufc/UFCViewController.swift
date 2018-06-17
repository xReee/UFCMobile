//
//  UFCViewController.swift
//  UFCMobile
//
//  Created by Renata on 28/05/18.
//  Copyright © 2018 Renata. All rights reserved.
//

import UIKit

class UFCViewController: BarraBrancaViewController, UITableViewDataSource, UITableViewDelegate {
    
    let opcoes = ["Calendário", "Mapa benfica", "Mapa Pici"]//["Notícias", "Calendário", "Mapa benfica", "Mapa Pici"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return opcoes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ufcCell")!
        cell.textLabel?.text = opcoes[indexPath.row ]
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
