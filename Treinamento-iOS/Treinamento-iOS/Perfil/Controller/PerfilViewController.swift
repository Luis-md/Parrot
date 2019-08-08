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

    @IBOutlet weak var perfilPic: UIImageView!
    @IBOutlet weak var usernameField: UILabel!
    @IBOutlet weak var amigosFT: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    var perfilService: PerfilService!
    var perfil: PerfilView?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.show()
        self.perfilService = PerfilService(delegate: self)
        self.perfilPic.layer.cornerRadius = self.perfilPic.frame.height / 2
        self.perfilService.getPerfil(id: SessionControl.user?.id.value ?? 0)
        
        //Preciso setar esses valores para que consiga carregar as celulas..
        //a partir daqui as coisas passam a funcionar..
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(cellType: PostTableViewCell.self)
    }

    @IBAction func configBtn(_ sender: Any) {
        
        let controller = StoryboardScene.Perfil.editPerfilViewController.instantiate()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    

}


extension PerfilViewController : perfilDelegate {
    func success() {
        self.perfil = PerfilViewModel.getPerfil(id: SessionControl.user?.id.value ?? 0)
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
        cell.bind(post: self.perfil!.posts[indexPath.row])
        
        return cell
    }
}


