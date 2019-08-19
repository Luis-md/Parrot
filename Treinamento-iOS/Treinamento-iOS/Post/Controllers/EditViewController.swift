//
//  EditViewController.swift
//  Treinamento-iOS
//
//  Created by Luis_md on 02/08/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import UIKit

protocol EditViewControllerDelegate {
    func edit(id: Int)
}

class EditViewController: UIViewController {
    
    @IBOutlet weak var editTextView: UITextView!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var fullEditView: UIView!
    
    var id: Int!
    var post: PostView!
    
    var delegate: EditViewControllerDelegate!
    var postService: PostService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postService = PostService(delegate: self)
        fullEditView.layer.cornerRadius = 10
        self.profilePic.layer.cornerRadius = self.profilePic.frame.height / 2
        self.post = PostViewModel.get(by: id)
    
        editTextView.text = post.postMessage
    }
    
    
    
    @IBAction func editBtn(_ sender: Any) {
        post.postMessage = editTextView.text
        self.postService.editPost(id: post.id, postMsg: post.postMessage)
    }

}

extension EditViewController : PostServiceDelegate {
    func success(type: ResponseType) {
        self.delegate.edit(id: post.id)
        self.navigationController?.popViewController(animated: true)
    }
    
    func failure(error: String) {
        print(error)
    }
    
    
}
