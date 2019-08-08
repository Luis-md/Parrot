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
        
        return Alamofire.request("\(baseUrl)/usuario?busca=\(nome)", method: .get, headers: SessionControl.headers)
    }
}
