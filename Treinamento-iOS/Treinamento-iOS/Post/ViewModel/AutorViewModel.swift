//
//  AutorView.swift
//  Treinamento-iOS
//
//  Created by Jobson Mateus on 29/07/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import Foundation
import RealmSwift

struct AutorView {
    var nome = ""
    var email = ""
    var username = ""
    var token = ""
}


class AutorViewModel{

    static func getAsView(autor: Autor?) -> AutorView {
        guard let autor = autor else {
            
            return AutorView()
        }
        
        
        //setando os valores para a struct a partir da instanciacao de PostView
        var autorView = AutorView()
        autorView.nome = autor.nome ?? ""
        autorView.email = autor.email ?? ""
        autorView.username = autor.username ?? ""
        autorView.token = autor.token ?? ""
        
        return autorView
    }

    static func getAsModel(autorView: AutorView) -> Autor {
        
        var autor = Autor()
        
        autor.nome = autorView.nome
        autor.email = autorView.email
        autor.username = autorView.username
        autor.token = autorView.token
        
        return autor
    }

    static func deleteAutor(){
        let results = uiRealm.objects(Post.self)
        
        try? uiRealm.write {
            
            uiRealm.delete(results)
        }
    }

}
