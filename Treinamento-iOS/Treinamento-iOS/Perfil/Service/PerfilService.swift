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
    func success()
    func failure(error: String)
}

class PerfilService{
    

    var delegate: perfilDelegate!
    init(delegate: perfilDelegate){
        self.delegate = delegate
    }
    
    func getPerfil(id: Int){
        
        
    }
}

