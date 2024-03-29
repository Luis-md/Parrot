//
//  AmizadeRequestFactory.swift
//  Treinamento-iOS
//
//  Created by Luis_md on 08/08/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import Foundation
import Alamofire

class AmizadeRequestFactory{
    
    static func getPerfil(nome: String) -> DataRequest {
        
        let params = ["busca" : nome]
        
        return Alamofire.request("\(baseUrl)/usuario", method: .get, parameters: params, headers: SessionControl.headers)
    }
    
    static func sendAmizade(id: Int) -> DataRequest {
        
        return Alamofire.request("\(baseUrl)/solicitacoes/\(id)", method: .post, headers: SessionControl.headers)
    }
    
    static func amizadeRecebida() -> DataRequest {
        
        return Alamofire.request("\(baseUrl)/solicitacoes/recebidas", method: .get, headers: SessionControl.headers)
    }
    
    static func amizadeAceita(id: Int) -> DataRequest {
        
        return Alamofire.request("\(baseUrl)/solicitacoes/amizade/\(id)", method: .post, headers: SessionControl.headers)
    }
}
