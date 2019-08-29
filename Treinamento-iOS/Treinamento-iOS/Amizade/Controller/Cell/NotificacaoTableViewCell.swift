//
//  NotificacaoTableViewCell.swift
//  Treinamento-iOS
//
//  Created by Luis_md on 14/08/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import UIKit
import Reusable
import Kingfisher

protocol NotificacaoTableViewDelegate {
    func accept(id: Int)
}

class NotificacaoTableViewCell: UITableViewCell, NibReusable {
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var noBtn: UIButton!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    
    var autor: AutorView!
    var delegate: NotificacaoTableViewDelegate!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.profilePic.layer.cornerRadius = self.profilePic.frame.height / 2
        
        self.okBtn.layer.cornerRadius = 5
        
        self.noBtn.layer.borderColor = UIColor.lightGray.cgColor
        self.noBtn.layer.cornerRadius = 5
    }
    
    func bind(autor: AutorView){
       
        self.autor = autor
        self.username.text = autor.username
        self.profilePic.kf.setImage(with: autor.urlImg)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func confirm(_ sender: Any) {
        
        self.delegate.accept(id: autor.id)
    }
    
    @IBAction func recusar(_ sender: Any) {
    }
}
