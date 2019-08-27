//
//  AutenticacaoRequestFactory.swift
//  Treinamento-iOS
//
//  Created by administrador on 25/07/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import Foundation
import Alamofire


class AutenticacaoRequestFactory {
    
    
    static func cadastro (nome: String, userName: String, email: String, password: String) -> DataRequest {
        
        let newUser = [ //enviando parametros solicitados para criacao de novo usuario
                        "nome": nome,
                        "username":userName,
                        "email": email,
                        "password": password
                      ]
        
        
        //retornando os parametros do newUser para serem enviados atraves do metodo post
        return Alamofire.request("\(baseUrl)/usuario", method: .post, parameters: newUser, encoding: JSONEncoding.default)
    }

    static func login (email: String, password: String) -> DataRequest {
        
        let loginUser = [ //enviando parametros solicitados para validar login
                        "email": email,
                        "password": password
                      ]
        
        
        //retornando os parametros do newUser para serem enviados atraves do metodo post
        return Alamofire.request("\(baseUrl)/usuario/login", method: .post, parameters: loginUser, encoding: JSONEncoding.default)
    }
    
}
