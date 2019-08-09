//
//  SearchTableViewCell.swift
//  Treinamento-iOS
//
//  Created by Luis_md on 09/08/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import UIKit
import Reusable
/*protocol SearchTableViewCellDelegate {
    func add(name: String)
}*/

class SearchTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var perfil: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var amigos: UILabel!
    
    
    //var delegate: SearchTableViewCellDelegate!
    var autor: AutorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.profilePic.layer.cornerRadius = self.profilePic.frame.height/2
        
    }

    func bind(autor: AutorView){
        
        self.autor = autor
        self.perfil.text = "@\(autor.username)"
        self.name.text = "\(autor.nome)"
    }
    
    @IBAction func addFriend(_ sender: Any) {
        
        //self.delegate.add(name: autor.username)
    }
}
