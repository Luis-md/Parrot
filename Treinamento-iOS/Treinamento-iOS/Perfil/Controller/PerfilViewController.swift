//
//  PerfilViewController.swift
//  Treinamento-iOS
//
//  Created by Luis_md on 06/08/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import UIKit

class PerfilViewController: UIViewController {

    @IBOutlet weak var perfilPic: UIImageView!
    @IBOutlet weak var usernameField: UILabel!
    @IBOutlet weak var amigosFT: UILabel!
    
    var perfilService: PerfilService!
    var perfil: PerfilView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.perfilService = PerfilService(delegate: self)
        self.perfilPic.layer.cornerRadius = self.perfilPic.frame.height / 2
    

        // Do any additional setup after loading the view.
    }
    

}


extension PerfilViewController : perfilDelegate {
    func success() {

        self.perfil = PerfilViewModel.getPerfil(id: SessionControl.user?.id.value ?? 0)
        
    }
    
    func failure(error: String) {
        print(error)
    }
    
    
}
