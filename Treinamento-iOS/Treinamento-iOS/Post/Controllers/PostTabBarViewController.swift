//
//  PostTabBarViewController.swift
//  Treinamento-iOS
//
//  Created by Luis_md on 30/07/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import UIKit

class PostTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let controllerPosts = StoryboardScene.PostStoryboard.postViewController.instantiate()
        controllerPosts.tabBarItem.title = "Home"
        controllerPosts.tabBarItem.image = Asset.houseOutline.image
        
        let controllerPerfil = StoryboardScene.Perfil.perfilViewController.instantiate()
        controllerPerfil.tabBarItem.title = "Perfil"
        controllerPerfil.tabBarItem.image = Asset.perfil1.image
        
        self.viewControllers = [controllerPosts, controllerPerfil]
    }
}


 
