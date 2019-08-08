//
//  AmizadeService.swift
//  Treinamento-iOS
//
//  Created by Luis_md on 08/08/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

protocol AmizadeDelegate {
    func success()
    func failure(error: String)
}

class AmizadeService {
    
    func getPerfil(nome: String){
        
        AmizadeRequestFactory.getPerfil(nome: nome).validate().response { (response: DataResponse<Perfil>) in
            
            switch response.result {
                
            case .success:
                
                if let perfil = response.result.value {
                    
                    perfilViewModel.save(object: perfil)
                }
            }
        }
        
        RequestFactory.getPerfil(id: id).validate().responseObject { (response: DataResponse<Perfil>) in
            
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
}
