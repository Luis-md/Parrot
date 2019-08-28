//
//  PerfilViewController.swift
//  Treinamento-iOS
//
//  Created by Luis_md on 06/08/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import UIKit
import SVProgressHUD
import Kingfisher

class PerfilViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var perfilPic: UIImageView!
    @IBOutlet weak var usernameField: UILabel!
    @IBOutlet weak var totalAmigos: UILabel!
    
    
    @IBOutlet weak var tableView: UITableView!
    var perfilService: PerfilService!
    var perfil: PerfilView?
    var amizadeService: AmizadeService!
    
    var posts: [PostView] = []
    
    var postagemService: PostService!
    var perfilId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.show()
        self.perfilService = PerfilService(delegate: self)
        self.amizadeService = AmizadeService(delegate: self)
        self.postagemService = PostService(delegate: self)
        
        self.perfilPic.layer.cornerRadius = self.perfilPic.frame.height / 2
        
        self.button.layer.cornerRadius = 5
        
       
        
        //Preciso setar esses valores para que consiga carregar as celulas..
        //a partir daqui as coisas passam a funcionar..
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(cellType: PostTableViewCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let id = self.perfilId, let userId = SessionControl.user?.id.value, userId != id {
            self.button.setTitle("Adicionar", for: .normal)
            self.perfilService.getPerfil(id: id)
        } else {
            
            self.perfilService.getPerfil(id: SessionControl.user?.id.value ?? 0)
        }
    }

    @IBAction func configBtn(_ sender: Any) {
        
        if let id = self.perfilId, let userId = SessionControl.user?.id.value, userId != id {
            self.amizadeService.sendFriend(id: id)
        } else {
            let controller = StoryboardScene.Perfil.editPerfilViewController.instantiate()
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}


extension PerfilViewController : perfilDelegate, AmizadeServiceDelegate, PostServiceDelegate {
    func failure(error: String) {
        print(error)
    }

    func success(type: ResponseType) {
        
        switch type {
        case .getPerfil:
            
            self.perfil = PerfilViewModel.getPerfil(id: self.perfilId ?? (SessionControl.user?.id.value ?? 0))
//            if let id = perfilId, let userId = SessionControl.user?.id.value, userId != id {
//                self.perfil = PerfilViewModel.getPerfil(id: id)
//            } else {
//                self.perfil = PerfilViewModel.getPerfil(id: SessionControl.user?.id.value ?? 0)
//            }
            self.usernameField.text = "@\(self.perfil?.autor.username ?? "")"
            self.perfilPic.kf.setImage(with: self.perfil?.autor.urlImg)
            let amigos = perfil?.autor.amigos.count
            if(amigos == 0){
                self.totalAmigos.text = "Sozinho no mundo"
            } else if (amigos == 1){
                self.totalAmigos.text = "\(amigos ?? 0) solitário"
            } else {
                self.totalAmigos.text = "\(amigos ?? 0) amigos"
            }
            self.tableView.reloadData()
            SVProgressHUD.dismiss()
            
            
        case .sendLike(let id):
            
            if let id = self.perfilId {
                self.perfil = PerfilViewModel.getPerfil(id: id)
            } else {
                self.perfil = PerfilViewModel.getPerfil(id: SessionControl.user?.id.value ?? 0)
            }
            
            if let index = self.perfil?.posts.firstIndex(where: {$0.id == id}) {
                self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: UITableView.RowAnimation.automatic)
            }

            
        default:
            break
        }
    }
}

extension PerfilViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.perfil?.posts.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(for: indexPath) as PostTableViewCell
        cell.delegate = self
        cell.bind(post: self.perfil!.posts[indexPath.row])
        
        if let id = perfilId, let userId = SessionControl.user?.id.value, userId != id {
            cell.optionBtn.isHidden = true
        } else {
            cell.optionBtn.isHidden = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(perfil!.posts[indexPath.row])
    }
}

extension PerfilViewController : PostTableViewCellDelegate {
    func curtido(id: Int, curtido: Bool) {
        print("botao apertado")
        self.postagemService.sendLike(id: id, curtido: curtido)
    }
    
    func optionPost(id: Int) {
            let optionMenu = UIAlertController(title: "O que deseja?", message: "", preferredStyle: .actionSheet)
            
            //utilizar as strings de titulo em localizable
            let deleteAction = UIAlertAction(title: "Deletar post", style: .default) { (UIAlertAction) in
                self.postagemService.delPost(id: id)
                
            }
            
            let editAction = UIAlertAction(title: "Editar post", style: .default) { (UIAlertAction) in
                
                let controller = StoryboardScene.PostStoryboard.editViewController.instantiate()
                controller.id = id
                controller.delegate = self
                self.navigationController?.pushViewController(controller, animated: true)
                
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) in
                
            }
            
            optionMenu.addAction(deleteAction)
            optionMenu.addAction(editAction)
            optionMenu.addAction(cancelAction)
            
            self.present(optionMenu, animated: true)
    }
        
}

extension PerfilViewController : EditViewControllerDelegate{
    func edit(id: Int) {
        
        self.posts = PostViewModel.getPosts()
        self.tableView.reloadData()
    }
}
