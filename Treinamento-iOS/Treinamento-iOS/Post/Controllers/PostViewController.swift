//
//  PostViewController.swift
//  Treinamento-iOS
//
//  Created by administrador on 26/07/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {

    @IBOutlet weak var groupView: UIView!
    @IBOutlet weak var perfilImage: UIImageView!
    @IBOutlet weak var postTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.groupView.layer.cornerRadius = 10
        
        self.perfilImage.layer.cornerRadius = self.perfilImage.frame.height / 2
    }
    

    
}
