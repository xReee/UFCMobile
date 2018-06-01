//
//  Cadeira.swift
//  UFCMobile
//
//  Created by Renata on 01/06/18.
//  Copyright © 2018 Renata. All rights reserved.
//

import UIKit

class Cadeira: NSObject {
    
    private let codigo : String
    private let nome : String
    private let local : String
    private var horario : [String:[String:String]]
    
    init(codigo: String, nome : String, local : String, horario: [String:[String:String]]) {
        
        self.codigo = codigo
        self.nome = nome
        self.local = local
        self.horario = horario
    }
    
    func get(_ propriedade : String) -> String{
        switch propriedade {
        case "codigo":
            return codigo
        case "nome":
            return nome
        case "local":
            return local
        default:
            return ""
        }
    }
    
}
