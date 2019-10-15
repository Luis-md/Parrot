//
//  Autor.swift
//  Treinamento-iOS
//
//  Created by Jobson Mateus on 29/07/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper


class sAutor: Object, Mappable {
    
    var id = RealmOptional<Int>()
    
    @objc dynamic var nome: String?
    @objc dynamic var email: String?
    @objc dynamic var username: String?
    @objc dynamic var foto: String?
    @objc dynamic var token: String?
    var amigos = List<Autor>()
    
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        return "id" //gerado pelo proprio servico
    }
    
    
    func mapping(map: Map){
        
        self.id.value       <- map["id"] //gerado pelo proprio servico para o bd
        self.nome           <- map["nome"]
        self.email          <- map["email"]
        self.username       <- map["username"]
        self.amigos         <- (map["amigos"], ListTransform<Autor>())
        self.foto           <- map["foto"]
        
    }
    
}
