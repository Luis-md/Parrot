//
//  PerfilRequestFactory.swift
//  Treinamento-iOS
//
//  Created by Luis_md on 05/08/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import Foundation
import Alamofire

class PerfilRequestFactory{
    
    static func getPerfil(id: Int) -> DataRequest {
        
        return Alamofire.request(baseUrl+"/usuario/\(id)", method: .get, headers: SessionControl.headers)
    }
    
    static func updtUser (nome: String, password: String) -> DataRequest {
        
        let updt = [ //enviando parametros solicitados para criacao de novo usuario
            "nome": nome,
            "password": password
        ]
        //retornando os parametros do newUser para serem enviados atraves do metodo post
        return Alamofire.request("\(baseUrl)/usuario", method: .put, parameters: updt, encoding: JSONEncoding.default, headers: SessionControl.headers)
    }
}
