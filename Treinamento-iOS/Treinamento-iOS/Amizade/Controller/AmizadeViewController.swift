//
//  AmizadeViewController.swift
//  Treinamento-iOS
//
//  Created by Luis_md on 09/08/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import UIKit

class AmizadeViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var amizadeService: AmizadeService!
    var autores: [AutorView] = []
    var perfilService: PerfilService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        self.amizadeService = AmizadeService(delegate: self)
        self.perfilService = PerfilService(delegate: self)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self        
        self.tableView.register(cellType: SearchTableViewCell.self)
        
        self.amizadeService.getPerfis(nome: "")
    }
}


extension AmizadeViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return self.autores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(for: indexPath) as SearchTableViewCell
        cell.delegate = self
        cell.bind(autor: self.autores[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}

extension AmizadeViewController : AmizadeServiceDelegate {
    func success(type: ResponseType) {
        self.autores = AutorViewModel.getAutors()
        self.tableView.reloadData()
    }
    
    func failure(error: String) {
        print(error)
    }
    
    
}

extension AmizadeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        self.amizadeService.getPerfis(nome: searchText)
    }
}

extension AmizadeViewController : SearchTableViewDelegate{
    func getPerfil(id: Int) {
        print("caiu aqui")
        let controller = StoryboardScene.Perfil.perfilViewController.instantiate()
        controller.perfilId = id
        self.navigationController?.pushViewController(controller, animated: true)
        self.perfilService.getPerfil(id: id)
    }
    
    func sendAmizade(id: Int) {
        print("request made")
        self.amizadeService.sendFriend(id: id)
    }
    
    
}

extension AmizadeViewController : perfilDelegate {
    
    
    
}
