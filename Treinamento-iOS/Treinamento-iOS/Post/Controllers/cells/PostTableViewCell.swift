//
//  PostTableViewCell.swift
//  Treinamento-iOS
//
//  Created by Luis_md on 30/07/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import UIKit
import Reusable //facilita para a gente poder colocar a celula na Table View


protocol PostTableViewCellDelegate {
    
    func curtido(id: Int)
}

class PostTableViewCell: UITableViewCell, NibReusable {
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var postText: UILabel!
    @IBOutlet weak var imagePost: UIImageView!
    
    @IBOutlet weak var like: UIButton!
    
    var delegate: PostTableViewCellDelegate!
    
    var post: PostView!
    
    
    //Time variables
    


    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.profilePic.layer.cornerRadius = self.profilePic.frame.height/2
    }

    func bind(post: PostView){
        
        self.post = post
        self.userName.text = "@\(post.autor.username)"
        self.postText.text = post.postMessage
        
        if post.curtido == false{
            self.like.tintColor = .gray
        } else {
            self.like.tintColor = .red
        }
    }
    
    @IBAction func likeButton(_ sender: Any) {
        
        self.delegate.curtido(post.id)
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
