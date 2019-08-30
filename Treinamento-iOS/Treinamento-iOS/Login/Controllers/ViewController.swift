//
//  ViewController.swift
//  Treinamento-iOS
//
//  Created by Jobson Mateus on 12/07/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import UIKit
import SVProgressHUD

class ViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    var service: AutenticacaoService!
    var passwordReveal = false
    @IBOutlet weak var passwordColor: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.service = AutenticacaoService(delegate: self)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func login(_ sender: Any) {
        
        if let email = emailText.text,
           let password = passwordText.text,
            !email.isEmpty && !password.isEmpty {
            self.service.loginUser(email: email, password: password)
            SVProgressHUD.show()        }
    }
    
    @IBAction func revelarPassword(_ sender: Any) {
        
        
        if passwordReveal == false {
            passwordReveal = true
            passwordColor.tintColor = .blue
        } else {
            passwordReveal = false
            passwordColor.tintColor = .gray
        }
        
        passwordText.isSecureTextEntry.toggle()
    }
 
    @IBAction func cadastrar(_ sender: Any) {
       
        let controller = StoryboardScene.Main.cadastroViewController.instantiate()
        
        
        self.navigationController?.pushViewController(controller, animated: true)
        
        /*service.cadastroUser(nome: "Francisco", username: "Da Silva", email: "fransilva@gmail.com", password: "12345678")*/
    }
    
    
    
}

extension ViewController: AutenticacaoServiceDelegate{
    func success() {
        SVProgressHUD.dismiss()
        ScreenManager.setupInitialViewController()
    }
    
    func failure(error: String) {
        SVProgressHUD.dismiss()
        
        switch error {
        case "Response status code was unacceptable: 401.":
            let alert = UIAlertController(title: "Erro no login", message: "Usuário e/ou senha inválidos", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        case "The Internet connection appears to be offline.":
            let alert = UIAlertController(title: "Erro no login", message: "Verifique sua conexão", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        default:
            print(error)
        }
    }
}

