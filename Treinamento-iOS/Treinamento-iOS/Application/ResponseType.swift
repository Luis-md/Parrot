//
//  ResponseType.swift
//  Treinamento-iOS
//
//  Created by Luis_md on 19/08/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import Foundation

enum ResponseType {
    case post
    case getPost
    case getPosts
    case sendLike(postId: Int)
    case delPost
    case editPost
    
    case getPerfil
    case updtPerfil
    case logoutPerfil
    case getSolicitacoes
    case aceitarAmigo
    
    case getPerfis
    case sendFriend
}
