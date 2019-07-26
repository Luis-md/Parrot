//
//  UsuarioViewModel.swift
//  Treinamento-iOS
//
//  Created by administrador on 25/07/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import Foundation
import RealmSwift


struct UsuarioView {
    
    var userName = ""
    
}


class UsuarioViewModel {
    
    static func save(object: User) {
    
        try? uiRealm.write {
            
            uiRealm.add(object, update: .all)
        }
    }
    
    static func delete() {
        
        try? uiRealm.write {
            uiRealm.deleteAll()
        }
    }
}
