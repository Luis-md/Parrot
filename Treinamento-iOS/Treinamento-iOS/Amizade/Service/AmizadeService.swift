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
    func success()
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
                
                self.delegate.success()
                
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
                
                self.delegate.success()
                
            case .failure(let error):
                self.delegate.failure(error: error.localizedDescription)
            }
            
        }
    }
}
