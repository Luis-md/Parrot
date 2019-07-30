//
//  CadastroViewController.swift
//  Treinamento-iOS
//
//  Created by administrador on 25/07/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import UIKit

class CadastroViewController: UIViewController {
    
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var service: AutenticacaoService!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.service = AutenticacaoService.init(delegate: self)
    }

    @IBAction func cadastrar(_ sender: Any) {
        
        
        if let fullname = fullName.text,
           let username = userName.text,
           let email = email.text,
           let password = password.text,
            !fullname.isEmpty && !username.isEmpty && !email.isEmpty && !password.isEmpty {
            
            self.service.cadastroUser(nome: fullname, username: username, email: email, password: password)
        }
    }
}

extension CadastroViewController: AutenticacaoServiceDelegate {
    func success() {
        
        self.navigationController?.popViewController(animated: true)
        
        ScreenManager.setupInitialViewController()
    }
    
    func failure(error: String) {
        
        print(error)
    }
    
    
}
