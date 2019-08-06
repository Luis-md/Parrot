//
//  SessionControl.swift
//  Treinamento-iOS
//
//  Created by administrador on 25/07/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import Foundation

class SessionControl {
    
    static var headers: [String : String] = [:]
    
    static var user: User? {
       return uiRealm.objects(User.self).first
    }
    
    static var isSessionActive: Bool {
        
        if let _ = self.user {
           
            return true
        }
        
        return false
    }
    
    static func setHeaders() {
        
        if let user = self.user {
            
            if let token = user.token {
                self.headers["token"] = token
            }
            print(self.headers["token"] ?? "-")
        }
    }
}
