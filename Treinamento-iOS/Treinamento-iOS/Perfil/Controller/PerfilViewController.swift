//
//  PerfilViewController.swift
//  Treinamento-iOS
//
//  Created by Luis_md on 06/08/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import UIKit
import SVProgressHUD

class PerfilViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var perfilPic: UIImageView!
    @IBOutlet weak var usernameField: UILabel!
    @IBOutlet weak var totalAmigos: UILabel!
    
    
    @IBOutlet weak var tableView: UITableView!
    var perfilService: PerfilService!
    var perfil: PerfilView?
    var amizadeService: AmizadeService!
  
    var postagemService: PostService!
    var perfilId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.show()
        self.perfilService = PerfilService(delegate: self)
        self.amizadeService = AmizadeService(delegate: self)
        self.perfilPic.layer.cornerRadius = self.perfilPic.frame.height / 2
        
        if let id = self.perfilId {
            self.button.setTitle("Adicionar", for: .normal)
            self.perfilService.getPerfil(id: id)
        } else {
        
            self.perfilService.getPerfil(id: SessionControl.user?.id.value ?? 0)
        }
        self.button.layer.cornerRadius = 5
        
       
        
        //Preciso setar esses valores para que consiga carregar as celulas..
        //a partir daqui as coisas passam a funcionar..
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(cellType: PostTableViewCell.self)
    
    }

    @IBAction func configBtn(_ sender: Any) {
        
        if let id = self.perfilId {
            self.amizadeService.sendFriend(id: id)
        } else {
            let controller = StoryboardScene.Perfil.editPerfilViewController.instantiate()
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    

}


extension PerfilViewController : perfilDelegate, AmizadeServiceDelegate {
    func success() {
        if let id = perfilId {
            self.perfil = PerfilViewModel.getPerfil(id: id)
        } else {
            self.perfil = PerfilViewModel.getPerfil(id: SessionControl.user?.id.value ?? 0)
        }
        self.usernameField.text = "@\(self.perfil?.autor.username ?? "")"
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
    }
    
    func failure(error: String) {
        print(error)
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(perfil!.posts[indexPath.row])
    }
}

extension PerfilViewController : PostTableViewCellDelegate {
    func curtido(id: Int, curtido: Bool) {
        self.postagemService.sendLike(id: id, curtido: curtido)
    }
    
    func optionPost(id: Int) {
        
    }
}
