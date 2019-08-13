//
//  SearchTableViewCell.swift
//  Treinamento-iOS
//
//  Created by Luis_md on 12/08/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import UIKit
import Reusable

class SearchTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var user: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    
    var autor: AutorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func bind(autor: AutorView){
        self.autor = autor
        self.user.text = autor.username
        self.email.text = autor.email
        
    }

    @IBAction func addFriend(_ sender: Any) {
    }
    
}
