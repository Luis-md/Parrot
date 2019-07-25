//
//  ViewController.swift
//  Treinamento-iOS
//
//  Created by Jobson Mateus on 12/07/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var emailTextField: UIView!
    @IBOutlet var passwordTextField: UIView!
    
    
    var service: AutenticacaoService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.service = AutenticacaoService(delegate: self)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func login(_ sender: Any) {
        
        
        
        service.loginUser(email: "fransilva@gmail.com", password: "12345678")
    }
 
    @IBAction func cadastrar(_ sender: Any) {
       
        let controller = StoryboardScene.Main.cadastroViewController.instantiate()
        
        self.navigationController?.pushViewController(controller, animated: true)
        
        
        /*service.cadastroUser(nome: "Francisco", username: "Da Silva", email: "fransilva@gmail.com", password: "12345678")*/
    }
    
    
}

extension ViewController: AutenticacaoServiceDelegate{
    func success() {
        print("Success")
    }
    
    func failure(error: String) {
        print(error)
    }
    
    
}

