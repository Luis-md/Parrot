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
    
    func getPosts() {
        PostRequestFactory.getPosts(pagina: 1).validate().responseArray { (response: DataResponse<[Post]>) in
            
            switch response.result {
                
            case .success:
                
                if let posts = response.result.value {
                    PostViewModel.saveAll(objects: posts, clear: true)
                }
                
                self.delegate.success()
                
            case .failure(let error):
                
                self.delegate.failure(error: error.localizedDescription)
            }
        }
    }
    
    func sendLike(id: Int, curtido: Bool) {
        
        PostRequestFactory.curtir(id: id, curtido: curtido).validate().responseObject { (response: DataResponse<Post>) in
            
            switch response.result {
            case .success:
                
                if let post = response.result.value {
                    PostViewModel.saveAll(objects: [post])
                }
                self.delegate.success()
                
            case .failure(let error):
                
                self.delegate.failure(error: error.localizedDescription)
            }
        }
    }
    
    func delPost(id: Int) {
        
        PostRequestFactory.delPost(id: id).validate().responseObject { (response: DataResponse<Post>) in
            
            switch response.result {
            case .success:
                
               // isso irá deletar a postagem do armazenamento local
                    PostViewModel.delPost(id: id)
                //}
                self.delegate.success()
                
            case .failure(let error):
                
                self.delegate.failure(error: error.localizedDescription)
            }
        }
    }
    
    func editPost(id: Int, postMsg: String) {
        
        PostRequestFactory.updtPost(id: id, postMsg: postMsg).validate().responseObject { (response: DataResponse<Post>) in
            
            switch response.result {
                
            case .success:
                
                if let post = response.result.value {
                    PostViewModel.saveAll(objects: [post])
                }
                self.delegate.success()
                
            case .failure(let error):
                
                self.delegate.failure(error: error.localizedDescription)
            }
        }
    }
}

