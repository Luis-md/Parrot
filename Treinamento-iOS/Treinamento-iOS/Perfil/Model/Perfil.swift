//
//  Perfil.swift
//  Treinamento-iOS
//
//  Created by Luis_md on 05/08/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper


class Perfil: Object, Mappable{
    

    @objc dynamic var autor: Autor?
    var posts = List<Post>()
    var id = RealmOptional<Int>()

    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func mapping(map: Map){
        self.id.value       <- map["usuario.id"]
        self.autor          <- map["usuario"]
        self.posts          <- (map["postagens"], ListTransform<Post>())
    }
}

