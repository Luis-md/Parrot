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
    var id = 0
    var amigos: [AutorView] = []
}


class AutorViewModel{
    
    static func saveAll(objects: [Autor], clear: Bool = false){
        
        if clear{
            self.deleteAutor()
        }
        
        try? uiRealm.write{
            uiRealm.add(objects, update: .all)
        }
    }
    
    //precisa ler do banco -
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
        autorView.id = autor.id.value ?? 0
        autorView.amigos = AutorViewModel.getAsView(autors: autor.amigos)

        
        return autorView
    }
    //so precisa caso tenha que enviar um objeto inteiro
    static func getAsModel(autorView: AutorView) -> Autor {
        
        let autor = Autor()
        
        autor.nome = autorView.nome
        autor.email = autorView.email
        autor.username = autorView.username
        autor.token = autorView.token
        
        return autor
    }

    static func deleteAutor(){
        let results = uiRealm.objects(Autor.self)
        
        try? uiRealm.write {
            
            uiRealm.delete(results)
        }
    }
    
    static func getAsView(autors: [Autor]) -> [AutorView] {
        
        var autorsView: [AutorView] = []
        autors.forEach { (autor) in
            
            autorsView.append(self.getAsView(autor: autor))
        }
        
        return autorsView
    }
    
    static func getAsView(autors: List<Autor>) -> [AutorView] {
        
        var autorsView: [AutorView] = []
        autors.forEach { (autor) in
            
            autorsView.append(self.getAsView(autor: autor))
        }
        
        return autorsView
    }
    
    static func get() -> [Autor] {
        let results = uiRealm.objects(Autor.self)
        
        var autors: [Autor] = []
        autors.append(contentsOf: results)
        
        return autors
    }
    
    static func getAutors() -> [AutorView] {
        
        return self.getAsView(autors: self.get())
    }
    
    
}
