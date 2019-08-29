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

protocol AmizadeServiceDelegate {
    func success(type: ResponseType)
    func failure(error: String)
}

class AmizadeService {
    
    var delegate: AmizadeServiceDelegate!
    init(delegate: AmizadeServiceDelegate) {
        self.delegate = delegate
    }
    
    
    func getPerfis(nome: String){
        
        AmizadeRequestFactory.getPerfil(nome: nome).validate().responseArray { (response: DataResponse<[Autor]>) in
            
            switch response.result {
                
            case .success:
                
                if let autor = response.result.value {
                    AutorViewModel.saveAll(objects: autor, clear: true)
                }
                
                self.delegate.success(type: .getPerfis)
                
            case .failure(let error):
                self.delegate.failure(error: error.localizedDescription)
            }
            
        }
    }
    
    func sendFriend(id: Int){
        
        AmizadeRequestFactory.sendAmizade(id: id).validate().responseObject { (response: DataResponse<Autor>) in
            
            switch response.result {
                
            case .success:
                
//                if let autor = response.result.value {
//                    AutorViewModel.saveAll(objects: [autor], clear: true)
//                }
                
                self.delegate.success(type: .sendFriend)
                
            case .failure(let error):
                self.delegate.failure(error: error.localizedDescription)
            }
            
        }
    }
    
    func getSolicitacoes(){
        
        AmizadeRequestFactory.amizadeRecebida().validate().responseArray { (response: DataResponse<[Autor]>) in
            
            switch response.result {
                
            case .success:
                
                if let autor = response.result.value {
                    AutorViewModel.saveAll(objects: autor, clear: true)
                }
                
                self.delegate.success(type: .getSolicitacoes)
                
            case .failure(let error):
                self.delegate.failure(error: error.localizedDescription)
            }
            
        }
    }
    
    func aceitarAmigo(id: Int){
        
        AmizadeRequestFactory.amizadeAceita(id: id).validate().responseObject { (response: DataResponse<Autor>) in
            switch response.result{
                
            case.success:
                
                AutorViewModel.delete(by: id)
                self.delegate.success(type: .aceitarAmigo(amigoId: id))
                
            case .failure(let error):
                self.delegate.failure(error: error.localizedDescription)
            }
        }
    }

    
}
