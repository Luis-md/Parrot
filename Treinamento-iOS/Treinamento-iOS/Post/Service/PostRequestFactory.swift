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
    
/*   static func requestWith(endUrl: String, imageData: Data?, parameters: [String : Any], onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil){
        
        let url = "http://google.com" /* your API url */
        
        let headers: HTTPHeaders = [
            /* "Authorization": "your_access_token",  in case you need authorization header */
            "Content-type": "multipart/form-data"
        ]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
            if let data = imageData{
                multipartFormData.append(data, withName: "image", fileName: "image.png", mimeType: "image/png")
            }
            
        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: headers) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print("Succesfully uploaded")
                    if let err = response.error{
                        onError?(err)
                        return
                    }
                    onCompletion?(nil)
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                onError?(error)
            }
        }
    }

  */
}
