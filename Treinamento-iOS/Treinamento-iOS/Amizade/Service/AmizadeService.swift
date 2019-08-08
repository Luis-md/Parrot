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
        
        AmizadeRequestFactory.getPerfil(nome: nome).validate().responseArray { (response: DataResponse<[Autor]>) in
        
            switch response.result {
                
            case .success:
                
                if let autor = response.result.value {
                    
                    AutorViewModel.saveAll(objects: autor, clear: true)
                }
                
            case .failure(let error):
                
                print(error.localizedDescription)
            }

        }
    }
}
