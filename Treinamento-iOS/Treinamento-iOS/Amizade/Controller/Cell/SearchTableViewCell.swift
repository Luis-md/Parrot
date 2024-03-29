//
//  SearchTableViewCell.swift
//  Treinamento-iOS
//
//  Created by Luis_md on 12/08/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//



import UIKit
import Reusable
import Kingfisher

protocol SearchTableViewDelegate {
    func sendAmizade(id: Int)
    func getPerfil(id: Int)
}

class SearchTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var user: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var userPerfil: UIButton!
    @IBOutlet weak var foto: UIImageView!
    @IBOutlet weak var button: UIButton!
    
    
    
    var autor: AutorView!
    var delegate: SearchTableViewDelegate!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    
    func bind(autor: AutorView){
        self.autor = autor
        self.email.text = autor.email
        self.userPerfil.setTitle("@\(autor.username)", for: .normal)
        self.userPerfil.layer.cornerRadius = 10
        self.foto.kf.setImage(with: autor.urlImg)
        self.foto.layer.cornerRadius = self.foto.frame.height/2
        self.button.layer.cornerRadius = 5
    }
    @IBAction func goPerfil(_ sender: Any) {
        
        self.delegate.getPerfil(id: autor.id)
    }
    
    @IBAction func addFriend(_ sender: Any) {

        self.delegate.sendAmizade(id: autor.id)
    }
    
}
