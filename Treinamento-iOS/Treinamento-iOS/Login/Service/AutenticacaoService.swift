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
                            
                            //salvando o usuario e setando os headers
                            UsuarioViewModel.save(object: user)
                            SessionControl.setHeaders()
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
                        UsuarioViewModel.delete()
                        UsuarioViewModel.save(object: user)
                        SessionControl.setHeaders()
                    }
                }
                
                self.delegate.success()
                
            case .failure(let error):
                
                self.delegate.failure(error: error.localizedDescription)
            }
            
            
        }
    }
    
    func cadastroPic(mimeType: String, extensao: String, fileName: String, data: Data, userName: String, password: String, fullName: String, email: String) {
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append(data, withName: "foto", fileName: "image.jpg", mimeType: "image/jpg")
            multipartFormData.append(fullName.data(using: String.Encoding.utf8)!, withName: "nome")
            multipartFormData.append(userName.data(using: String.Encoding.utf8)!, withName: "username")
            multipartFormData.append(email.data(using: String.Encoding.utf8)!, withName: "email")
            multipartFormData.append(password.data(using: String.Encoding.utf8)!, withName: "password")
            
        }, usingThreshold: UInt64(), to: baseUrl + "/usuario", method: .post, headers: SessionControl.headers) { (result) in
            
            
            switch result{
            case .success(let upload, _, _):
                
                upload.responseObject(completionHandler: { (response: DataResponse<User>) in
                    
                    if let user = response.result.value {
                        if let token = response.response?.allHeaderFields["token"] as? String {
                            user.token = token
                            
                            UsuarioViewModel.save(object: user)
                            SessionControl.setHeaders()
                        }
                    }
                })
                print("Cadastrou!!")
                self.delegate.success()
            case .failure(let error):
                self.delegate.failure(error: error.localizedDescription)
            }
        }
    }
}

