//
//  PerfilService.swift
//  Treinamento-iOS
//
//  Created by Luis_md on 05/08/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

protocol perfilDelegate {
    func success(type: ResponseType)
    func failure(error: String)
}

class PerfilService{
    

    var delegate: perfilDelegate!
    init(delegate: perfilDelegate){
        self.delegate = delegate
    }
    
    func getPerfil(id: Int){
        PerfilRequestFactory.getPerfil(id: id).validate().responseObject { (response: DataResponse<Perfil>) in
            
            switch response.result {
                
            case .success:
                
                //checando se o valor é nulo ou nao
                if let perfil = response.result.value {
                    PerfilViewModel.save(object: perfil)
                }
                self.delegate.success(type: .getPerfil)
                
            case .failure(let error):
                
                self.delegate.failure(error: error.localizedDescription)
            }
        }
    }
    
    func updtPerfil(name: String, password: String){
        PerfilRequestFactory.updtUser(nome: name, password: password).validate().responseObject { (response: DataResponse<Perfil>) in
            
            switch response.result {
            case .success:
                if let perfil = response.result.value {
                    PerfilViewModel.save(object: perfil)
                }
                self.delegate.success(type: .getPerfil)
                
            case .failure(let error):
                
                self.delegate.failure(error: error.localizedDescription)
            }
        
        }
    }
    
    func logoutPerfil(){
        
        PerfilRequestFactory.logout().validate().responseObject { (response: DataResponse<Perfil>) in
            
            UsuarioViewModel.delete()
            ScreenManager.setupInitialViewController()
        }
    }
    
    func updtPerfilPic(mimeType: String, extensao: String, fileName: String, data: Data, name: String, password: String) {
        
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append(data, withName: "foto", fileName: "image.jpg", mimeType: "image/jpg")
            multipartFormData.append(name.data(using: String.Encoding.utf8)!, withName: "nome")
            multipartFormData.append(password.data(using: String.Encoding.utf8)!, withName: "password")
            
        }, usingThreshold: UInt64(), to: baseUrl + "/usuario", method: .put, headers: SessionControl.headers) { (result) in
            
            
            switch result{
            case .success(let upload, _, _):
                
                self.delegate.success(type: .getPerfil)
                
            case .failure(let error):
                self.delegate.failure(error: error.localizedDescription)
            }
        }
        
    }

}
