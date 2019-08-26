//
//  PostViewModel.swift
//  Treinamento-iOS
//
//  Created by Jobson Mateus on 29/07/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import Foundation
import RealmSwift
import MobileCoreServices
import Kingfisher

struct PostView {
    
    var id = 0
    var postMessage = ""
    var curtidas = 0
    var criado_em = Date(timeIntervalSince1970: 0)
    var autor = AutorView()
    var curtido = false
    var postImg = ""
    
    
    var dateString: String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.dateFormat = "dd MMM yyyy"
        
        return dateFormatter.string(from: self.criado_em)
    }
    
    var urlImg: URL? {

        return URL(string: baseUrl + self.postImg)
    }
}

class PostViewModel {
    
    //offline first
    static func saveAll(objects: [Post], clear: Bool = false){
     
        if clear{
            self.deletePosts()
        }
        
        try? uiRealm.write{
            uiRealm.add(objects, update: .all)
        }
    }
    
    static func getAsView(post: Post?) -> PostView {
        guard let post = post else {
            
            return PostView()
        }
        
        //setando os valores para a struct a partir da instanciacao de PostView
        var postView = PostView()
        postView.id = post.id.value ?? 0
        postView.postMessage = post.postMessage ?? ""
        postView.curtidas = post.curtidas.value ?? 0
        postView.criado_em = Date(timeIntervalSince1970: TimeInterval(post.criado_em.value ?? 0)) 
        postView.autor = AutorViewModel.getAsView(autor: post.autor)
        postView.curtido = post.curtido.value ?? false
        postView.postImg = post.postPic ?? ""
        
        
        return postView
    }
    
    static func getAsView(posts: [Post]) -> [PostView] {
        
        var postsView: [PostView] = []
        posts.forEach { (post) in
            
            postsView.append(self.getAsView(post: post))
        }
        
        return postsView
    }
    
    static func getAsViewPerfil(posts: List<Post>) -> [PostView] {
        
        var postsView: [PostView] = []
        posts.forEach { (post) in
            
            postsView.append(self.getAsView(post: post))
        }
        
        return postsView
    }
    //-------------------------
    static func get() -> [Post] {
        let results = uiRealm.objects(Post.self)
        
        var posts: [Post] = []
        posts.append(contentsOf: results)
        
        return posts
    }
    
    static func getPosts() -> [PostView] {
        
        return self.getAsView(posts: self.get()).sorted(by: {$0.criado_em > $1.criado_em})
    }
    //-----------------
    static func get(by id: Int) -> PostView {
        
        let result = uiRealm.object(ofType: Post.self, forPrimaryKey: id)
        return self.getAsView(post: result)
    }
    
    static func getAsModel(postView: PostView) -> Post {
        
        let post = Post()
        
        post.id.value = postView.id
        post.postMessage = postView.postMessage
        post.curtidas.value = postView.curtidas
//      post.criado_em.value = postView.criado_em
        post.autor = AutorViewModel.getAsModel(autorView: postView.autor)
        post.curtido.value = postView.curtido
        post.postPic = postView.postImg

        
        return post
    }
    
    static func deletePosts(){
        
        let results = uiRealm.objects(Post.self)
        
        try? uiRealm.write {
            uiRealm.delete(results)
        }
    }
    
    static func delPost(id: Int) {
        let result = uiRealm.object(ofType: Post.self, forPrimaryKey: id)!
        
        try? uiRealm.write {
            uiRealm.delete(result)
        }
    }
    
    static func lastPathExtension(fileName: String) -> String {
        
        let arrayFileName = fileName.components(separatedBy: ".")
        let mimeTypeExtension = arrayFileName[(arrayFileName.count - 1)]
        
        return mimeTypeExtension
    }
    
    static func mimeTypeFromFileExtension(fileExtension: String) -> String? {
        
        guard let uti: CFString = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, fileExtension as NSString, nil)?.takeRetainedValue() else {
            return nil
        }
        
        guard let mimeType: CFString = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() else {
            return "application/octet-stream"
        }
        
        return mimeType as String
    }
}
