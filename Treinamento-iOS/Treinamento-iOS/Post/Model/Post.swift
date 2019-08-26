//
//  Post.swift
//  Treinamento-iOS
//
//  Created by administrador on 26/07/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper


class Post: Object, Mappable{
  
    var id = RealmOptional<Int>()
    @objc dynamic var postMessage: String?
    var curtidas = RealmOptional<Int>()
    var criado_em = RealmOptional<Int>()
    @objc dynamic var autor: Autor?
    var curtido = RealmOptional<Bool>()
    @objc dynamic var postPic: String?
    
    required convenience init?(map: Map) {
        
        self.init()
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func mapping(map: Map) {
        
        self.id.value               <- map["id"]
        self.postMessage            <- map["mensagem"]
        self.autor                  <- map["autor"]
        self.curtidas.value         <- map["curtidas"]
        self.criado_em.value        <- map["criado_em"]
        self.curtido.value          <- map["curtido"]
        self.postPic                <- map["imagem"]
    }
}

