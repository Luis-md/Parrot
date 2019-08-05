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
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map){
        
        self.autor          <- map["autor"]
        self.posts          <- map["postagens"]
    }
    
}

