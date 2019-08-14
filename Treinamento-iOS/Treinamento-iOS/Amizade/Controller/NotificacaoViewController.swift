//
//  NotificacaoViewController.swift
//  Treinamento-iOS
//
//  Created by Luis_md on 14/08/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import UIKit

class NotificacaoViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var amizadeService: AmizadeService!
    var autores: [AutorView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.amizadeService = AmizadeService(delegate: self)
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(cellType: NotificacaoTableViewCell.self)
        
        self.amizadeService.getSolicitacoes()
    }


}

extension NotificacaoViewController : AmizadeServiceDelegate{
    func success() {
        
        self.autores = AutorViewModel.getAutors()
        self.tableView.reloadData()
    }
    
    func failure(error: String) {
        
        print(error)
    }
    
    
}

extension NotificacaoViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return autores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(for: indexPath) as NotificacaoTableViewCell
        cell.delegate = self
        cell.bind(autor: self.autores[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}

extension NotificacaoViewController : NotificacaoTableViewDelegate{
    func accept(id: Int) {
        
        self.amizadeService.aceitarAmigo(id: id)
    }
}
