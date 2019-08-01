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
    @IBOutlet weak var tableView: UITableView!
    
    
    var postagemService: PostService!
    var posts: [PostView] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.postagemService = PostService(delegate: self)
        
        self.groupView.layer.cornerRadius = 10
        self.perfilImage.layer.cornerRadius = self.perfilImage.frame.height / 2
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(cellType: PostTableViewCell.self)
             
        self.postagemService.getPosts()
    }
    
    @IBAction func sendPost(_ sender: Any) {
        
        postagemService.post(postMsg: postTextView.text)
    }
}


extension PostViewController: PostServiceDelegate {
    func success() {
        
        self.posts = PostViewModel.getPosts()
        self.tableView.reloadData()
        print(posts.count)
    }
    
    func failure(error: String) {
        
        print(error)
    }
}

extension PostViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(for: indexPath) as PostTableViewCell
        cell.bind(post: self.posts[indexPath.row])
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 400
    }
}

extension PostViewController : PostTableViewCellDelegate {
    func curtido(id: Int, curtido: Bool) {
        self.postagemService.sendLike(id: id, curtido: curtido)
    }
    
    func optionPost(id: Int) {
        
        let optionMenu = UIAlertController(title: nil, message: "Escolha uma opção", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .default) { (UIAlertAction) in
            self.postagemService.delPost(id: id)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
}
