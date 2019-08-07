//
//  PerfilService.swift
//  Treinamento-iOS
//
//  Created by Luis_md on 05/08/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

protocol perfilDelegate {
    func success()
    func failure(error: String)
}

class PerfilService{
    

    var delegate: perfilDelegate!
    init(delegate: perfilDelegate){
        self.delegate = delegate
    }
    
    func getPerfil(id: Int){
        PerfilRequestFactory.getPerfil(id: id).validate().responseObject { (response: DataResponse<Perfil>) in
            
            switch response.result {
                
            case .success:
                
                //checando se o valor é nulo ou nao
                if let perfil = response.result.value {
                    PerfilViewModel.save(object: perfil)
                }
                self.delegate.success()
                
            case .failure(let error):
                
                self.delegate.failure(error: error.localizedDescription)
            }
        }
    }
    
    func updtPerfil(name: String, password: String){
        PerfilRequestFactory.updtUser(nome: name, password: password).validate().responseObject { (response: DataResponse<Perfil>) in
            
            switch response.result {
            case .success:
                if let perfil = response.result.value {
                    PerfilViewModel.save(object: perfil)
                }
                self.delegate.success()
                
            case .failure(let error):
                
                self.delegate.failure(error: error.localizedDescription)
            }
        
        }
    }
}
