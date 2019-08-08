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
        
        return Alamofire.request("\(baseUrl)/usuario", method: .get, parameters: params, encoding: JSONEncoding.default, headers: SessionControl.headers)
    }
}
