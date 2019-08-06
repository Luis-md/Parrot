//
//  PerfilViewModel.swift
//  Treinamento-iOS
//
//  Created by Luis_md on 05/08/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import Foundation

struct PerfilView {
    
    var autor = AutorView()
    var posts: [PostView] = []
}

class PerfilViewModel{
    
    static func saveAll(objects: Perfil, clear: Bool = false){
        
        if clear{
            self.deletePerfil()
        }
        
        try? uiRealm.write{
            uiRealm.add(objects, update: .all)
        }
    }
    
    static func deletePerfil(){
        
        let results = uiRealm.objects(Perfil.self)
        try? uiRealm.write {

            uiRealm.delete(results)
        }
    }

    static func get(by id: Int) -> Perfil? {
        
        let results = uiRealm.object(ofType: Perfil.self, forPrimaryKey: id)
        
        return results
    }
    
    static func getAsView(perfil: Perfil?) -> PerfilView {
        guard let perfil = perfil else {
            
            return PerfilView()
        }
        //setando os valores para a struct a partir da instanciacao de PostView
        var perfilView = PerfilView()
        perfilView.autor = AutorViewModel.getAsView(autor: perfil.autor)
        perfilView.posts = PostViewModel.getAsViewPerfil(posts: perfil.posts)
        
        return perfilView
    }
 
    static func getPerfil(id: Int) -> PerfilView {
        
        return self.getAsView(perfil: self.get(by: id))
    }
    
    
}
