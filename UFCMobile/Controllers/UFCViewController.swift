//
//  UFCViewController.swift
//  UFCMobile
//
//  Created by Renata on 28/05/18.
//  Copyright © 2018 Renata. All rights reserved.
//

import UIKit

class UFCViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let opcoes = ["Notícias", "Calendário", "Mapa benfica", "Mapa Pici"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ufcCell")!
        cell.textLabel?.text = opcoes[indexPath.row ]
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }


}