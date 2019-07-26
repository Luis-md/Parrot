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
    
    
    static func postPost(postmsg: String) -> DataRequest {
        
        let postMessage: [String : String] = ["mensagem":postmsg]
        
        return Alamofire.request(baseUrl+"/postagem", method: .post, parameters: postMessage, encoding: JSONEncoding.default, headers: SessionControl.headers)
    }
}
