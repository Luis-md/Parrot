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
    @IBOutlet weak var confirmPassword: UITextField!
    
    var service: AutenticacaoService!
    override func viewDidLoad() {
        super.viewDidLoad()

        
       // self.service = AutenticacaoService.init(delegate: self)
    }

    @IBAction func cadastrar(_ sender: Any) {
        
        let controller = StoryboardScene.Main.concluirCadastroViewController.instantiate()
        
        if let fullName = fullName.text,
            let userName = userName.text,
            let email = email.text,
            let password = password.text,
            let confirmPass = confirmPassword.text,
            !fullName.isEmpty && !userName.isEmpty && !email.isEmpty && !password.isEmpty && !confirmPass.isEmpty {
            
            if confirmPass != password {
                let alert = UIAlertController(title: "Erro ❌", message: "Campos de password não estão iguais", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            } else {
            
                controller.fullName = fullName
                controller.userName = userName
                controller.email = email
                controller.password = password
                
                self.navigationController?.pushViewController(controller, animated: true)
            }
        }
    }
    
}
