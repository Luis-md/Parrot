//
//  PostService.swift
//  Treinamento-iOS
//
//  Created by administrador on 26/07/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

protocol PostServiceDelegate {
    func success()
    
    func failure(error: String)
}

class PostService {
    
    var delegate: PostServiceDelegate!
    
    init(delegate: PostServiceDelegate) {
        self.delegate = delegate
    }
    

    func post(postMsg: String) {
        
        PostRequestFactory.sendPost(postMsg: postMsg).validate().responseObject { (response: DataResponse<Post>) in
            
            switch response.result {
            case .success:
                
                if let postMsg = response.result.value {
                    PostViewModel.saveAll(objects: [postMsg])
                }
                self.delegate.success()
                
            case .failure(let error):
                
                self.delegate.failure(error: error.localizedDescription)
            }
        }
    }
}

