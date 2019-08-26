//
//  PostRequestFactory.swift
//  Treinamento-iOS
//
//  Created by administrador on 26/07/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import Foundation
import Alamofire


class PostRequestFactory {
    
    
    static func sendPost(postMsg: String) -> DataRequest {
        
        let postMessage: [String : String] = ["mensagem":postMsg]
        
        return Alamofire.request(baseUrl+"/postagem", method: .post, parameters: postMessage, encoding: JSONEncoding.default, headers: SessionControl.headers)
    }
    
    static func getPosts(pagina: Int) -> DataRequest {
        
        let param = ["pagina":pagina]
        
        return Alamofire.request(baseUrl+"/postagem", method: .get, parameters: param, headers: SessionControl.headers)
    }
    
    static func curtir(id: Int, curtido: Bool) -> DataRequest {
        
        return Alamofire.request(baseUrl+"/curtir/\(id)", method: curtido ? .delete : .post, headers: SessionControl.headers)
    }
    
    static func delPost(id: Int) -> DataRequest {
        
        return Alamofire.request(baseUrl+"/postagem/\(id)", method: .delete, headers: SessionControl.headers)
    }
    
    static func updtPost(id: Int, postMsg: String) -> DataRequest {
        
        let param = ["mensagem":postMsg]
        
        return Alamofire.request(baseUrl+"/postagem/\(id)", method: .put, parameters: param, encoding: JSONEncoding.default, headers: SessionControl.headers)
    }
    
    //Post com imagem -------

    
    

 
}
