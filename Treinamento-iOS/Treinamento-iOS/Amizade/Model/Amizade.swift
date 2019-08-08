//
//  Amizade.swift
//  Treinamento-iOS
//
//  Created by Luis_md on 08/08/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class Amizade: Object, Mappable {
    
    
    var id = RealmOptional<Int>()
    @objc dynamic var nome: String?
    @objc dynamic var email: String?
    @objc dynamic var username: String?
    //@objc dynamic var pic: String?
    //@objc dynamic var amigos = [Array]()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func mapping(map: Map) {
        
        self.id.value       <- map["id"]
        self.nome           <- map["nome"]
        self.email          <- map["email"]
        self.username       <- map["username"]
    }
    
    
    
}
