//
//  Cadeira.swift
//  UFCMobile
//
//  Created by Renata on 01/06/18.
//  Copyright © 2018 Renata. All rights reserved.
//

import UIKit

class Cadeira: NSObject {
    
    private var turno = "manhã"
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
    
    func getTurno() -> String {
        return turno
    }
    
    func getHorarioInicio(dia:String) -> String{
        guard let dias = horario[dia] else {
            return ""
        }
        guard let horarioInicio = dias["inicio"] else {
            return ""
        }
        let horaToda = horarioInicio.components(separatedBy: ":")
        let horaInt = Int(horaToda.first!)
        if horaInt! < 12 {
            self.turno = "manhã"
        } else if horaInt! <= 17 {
            self.turno = "tarde"
        } else {
            self.turno = "noite"
        }
        
        return horarioInicio
        
    }
    
    func getHorarioInt(dia:String, _ qual: String) -> Int {
        guard let dias = horario[dia] else {
            return 0
        }
        guard let horarioInicio = dias[qual] else {
            return 0
        }
        let horaToda = horarioInicio.components(separatedBy: ":")
        let horaInt = Int(horaToda.first!)
        return horaInt!
    }
    
    
}
