//
//  User.swift
//  Treinamento-iOS
//
//  Created by administrador on 24/07/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper


class User: Object, Mappable {
    
    var id = RealmOptional<Int>()
    
    @objc dynamic var nome: String?
    @objc dynamic var email: String?
    @objc dynamic var username: String?
    @objc dynamic var foto: String?

    required convenience init?(map: Map) {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    
    func mapping(map: Map){
        
        self.id.value       <- map["id"]
        self.nome           <- map["nome"]
        self.email          <- map["email"]
        self.username       <- map["username"]
        self.foto           <- map["foto"]
       
        
    }

}
