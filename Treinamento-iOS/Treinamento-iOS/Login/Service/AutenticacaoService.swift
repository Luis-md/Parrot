//
//  AutenticacaoService.swift
//  Treinamento-iOS
//
//  Created by administrador on 25/07/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

protocol AutenticacaoServiceDelegate { //protocolo para ser implementado ao instanciar a classe
    
    func success()
    func failure(error: String)
}


class AutenticacaoService {
    
    var delegate: AutenticacaoServiceDelegate!
    
    init(delegate: AutenticacaoServiceDelegate) {
        self.delegate = delegate
    }
    
    
    //metodo que ira cuidar de cadastrar um novo usuario
    func cadastroUser(nome: String, username: String, email: String, password: String){
        
        
        AutenticacaoRequestFactory.cadastro(nome: nome, userName: username, email: email, password: password).validate().responseObject { (response: DataResponse<User>) in
            
            
            switch response.result {
                
                case .success:
                
                    if let user = response.result.value {
                        //pegando o token gerado no Postman
                        //token serve para identificar o usuario na aplicacao
                        if let token = response.response?.allHeaderFields["token"] as? String {
                            user.token = token
                            print("Register ok!")
                        }
                        
                        
                    }
                self.delegate.success()
                
                case .failure(let error):
                
                    self.delegate.failure(error: error.localizedDescription)
            }
            
            
        }
    }
    
    
    func loginUser(email: String, password: String){
        
        AutenticacaoRequestFactory.login(email: email, password: password).validate().responseObject { (response: DataResponse<User>) in
            
            
            switch response.result {
                
            case .success:
                
                if let user = response.result.value {
                    //pegando o token gerado no Postman
                    //token serve para identificar o usuario na aplicacao
                    if let token = response.response?.allHeaderFields["token"] as? String {
                        user.token = token
                        print("Login ok!")
                    }
                    
                    
                }
                self.delegate.success()
                
            case .failure(let error):
                
                self.delegate.failure(error: error.localizedDescription)
            }
            
            
        }
    }
}

