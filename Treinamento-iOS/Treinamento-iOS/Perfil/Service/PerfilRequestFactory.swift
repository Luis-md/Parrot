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
}
