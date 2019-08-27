//
//  EditPerfilViewController.swift
//  Treinamento-iOS
//
//  Created by Luis_md on 05/08/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import UIKit
import Kingfisher

protocol EditPerfilDelegate {
    func updtProfile(name: String, password: String)
}

class EditPerfilViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var profilePic: UIImageView!
    
    var perfil: PerfilView!
    
    
    
    var delegate: EditPerfilDelegate!
    var perfilService: PerfilService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        perfilService = PerfilService(delegate: self)
        self.profilePic.layer.cornerRadius = self.profilePic.frame.height / 2
        self.profilePic.kf.setImage(with: self.perfil?.autor.urlImg)


       /* self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Concluir", style: .done, target: self, action: #selector(method(for:)))*/
    }
    
    @IBAction func updtInfo(_ sender: Any) {
        
        if let name = name.text,
           let password = password.text,
           !name.isEmpty && !password.isEmpty {
            
            self.perfilService.updtPerfil(name: name, password: password)
        }
    }
    
    @IBAction func logout(_ sender: Any) {
        
        perfilService.logoutPerfil()
    }
    
}

extension EditPerfilViewController: perfilDelegate {
    func success(type: ResponseType) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func failure(error: String) {
        print(error)
    }
    
    
}


