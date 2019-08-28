//
//  PostViewController.swift
//  Treinamento-iOS
//
//  Created by administrador on 26/07/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import UIKit
import Photos
import Kingfisher

class PostViewController: UIViewController {

    @IBOutlet weak var groupView: UIView!
    @IBOutlet weak var perfilImage: UIImageView!
    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    var imagePicker = UIImagePickerController()
    var imageImported: UIImageView?
    var imageDetail: [String : String] = [:]
    var data: Data?
    
    var postagemService: PostService!
    var posts: [PostView] = []
    
    /*var urlImg: URL? {
        
        return URL(string: baseUrl + )
    }*/

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.postagemService = PostService(delegate: self)
        
        self.groupView.layer.cornerRadius = 10
        self.perfilImage.layer.cornerRadius = self.perfilImage.frame.height / 2
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(cellType: PostTableViewCell.self)
        
        self.imagePicker.delegate = self
        
        self.postagemService.getPosts()
        //self.perfilPic.kf.setImage(with: self.SessionControl.user?.foto)
    }
    @IBAction func imagePick(_ sender: Any) {
        
        
        self.imagePicker.delegate = self
        self.imagePicker.sourceType = .photoLibrary
        
        PHPhotoLibrary.requestAuthorization { (status) in
            if status == .authorized {
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    
                    self.present(self.imagePicker, animated: true)
                }
            } else {
                print("AA")
            }
        }
    }
    
    

    
    
    
    @IBAction func sendPost(_ sender: Any) {
        
        
        if let data = self.data {
            self.postagemService.sendAnexo(mimeType: imageDetail["mimeType"] ?? "", extensao: imageDetail["mimeTypeExtension"] ?? "", fileName: imageDetail["fileName"] ?? "", data: data, postMsg: postTextView.text)
        } else {
            postagemService.post(postMsg: postTextView.text)
        }
        
    }
}


extension PostViewController: PostServiceDelegate {
    func success(type: ResponseType) {
        
        switch type {
        case .sendLike(let id):
            self.posts = PostViewModel.getPosts()
            if let index = self.posts.firstIndex(where: {$0.id == id}) {
                self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: UITableView.RowAnimation.automatic)
            }
            
            
        default:
            self.posts = PostViewModel.getPosts()
            self.tableView.reloadData()
        }
    }
    
    func failure(error: String) {
        
        print(error)
    }
}

extension PostViewController : UITableViewDataSource, UITableViewDelegate {
    
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
        
        let optionMenu = UIAlertController(title: L10n.Common.deseja, message: "", preferredStyle: .actionSheet)
        
        //utilizar as strings de titulo em localizable 
        let deleteAction = UIAlertAction(title: L10n.Common.delPost, style: .default) { (UIAlertAction) in
            self.postagemService.delPost(id: id)

        }
        
        let editAction = UIAlertAction(title: L10n.Common.edtPost, style: .default) { (UIAlertAction) in
            
            let controller = StoryboardScene.PostStoryboard.editViewController.instantiate()
            controller.id = id
            controller.delegate = self
            self.navigationController?.pushViewController(controller, animated: true)
            
        }
        
        let cancelAction = UIAlertAction(title: L10n.Common.cancel, style: .cancel) { (UIAlertAction) in
            
        }
        
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(editAction)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true)
    }
}

extension PostViewController : EditViewControllerDelegate {
    func edit(id: Int) {
        self.posts = PostViewModel.getPosts()
        self.tableView.reloadData()
    }
}


extension PostViewController : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func getFileName(info: [String : Any]) -> String {
        
        if let imageURL = info[UIImagePickerControllerReferenceURL] as? URL {
            
            let result = PHAsset.fetchAssets(withALAssetURLs: [imageURL], options: nil)
            
            let asset = result.firstObject
            
            let fileName = asset?.value(forKey: "filename")
            
            if let fileString = fileName as? String {
                
                let fileUrl = URL(string: fileString)
                
                if let name = fileUrl?.lastPathComponent {
                    
                    return name
                }
            }
        }
        
        return "asset.JPG"
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var error: String?
        
        let fileName = self.getFileName(info: info)
        let mimeTypeExtension = PostViewModel.lastPathExtension(fileName: fileName)
        let mimeType: String = PostViewModel.mimeTypeFromFileExtension(fileExtension: mimeTypeExtension)!
        
        // MARK: Photo
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            self.data = UIImageJPEGRepresentation(image, 0.25)!
//            self.postagemService.sendAnexo(mimeType: mimeType, extensao: mimeTypeExtension, fileName: fileName, data: data)
            
            self.imageDetail = ["fileName" : fileName,
                                "mimeTypeExtension" : mimeTypeExtension,
                                "mimeType" : mimeType]
        }
        self.dismiss(animated: true, completion: nil)
    }
}

