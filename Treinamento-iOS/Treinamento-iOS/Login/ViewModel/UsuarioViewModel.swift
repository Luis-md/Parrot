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
    
    var nome = ""
    var userName = ""
    var email = ""
    var perfilPic = ""
    
    var urlImg: URL? {
        
        return URL(string: baseUrl + self.perfilPic)
    }

}


class UsuarioViewModel {
    
    static func save(object: User) {
    
        try? uiRealm.write {
            
            uiRealm.add(object, update: .all)
        }
    }
    
    static func getAsView(user: User?) -> UsuarioView {
        guard let user = user else {
            
            return UsuarioView()
        }
        
        
        //setando os valores para a struct a partir da instanciacao de PostView
        var userView = UsuarioView()
        userView.nome = user.nome ?? ""
        userView.userName = user.username ?? ""
        userView.email = user.email ?? ""
        userView.perfilPic = user.foto ?? ""
        
        
        return userView
    }
    
    
    static func delete() {
        
        try? uiRealm.write {
            uiRealm.deleteAll()
        }
    }
}
