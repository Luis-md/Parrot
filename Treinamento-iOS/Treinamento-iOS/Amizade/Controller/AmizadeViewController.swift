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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setar delegate da SearchBar
        self.amizadeService = AmizadeService(delegate: self)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self        
        self.tableView.register(cellType: SearchTableViewCell.self)
        
        self.amizadeService.getPerfis(nome: "matelalove")
    }
    


}


extension AmizadeViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return self.autores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(for: indexPath) as SearchTableViewCell
        cell.bind(autor: self.autores[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}

extension AmizadeViewController : AmizadeServiceDelegate {
    func success() {
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
    }
}
