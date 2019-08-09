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
    
    
}

extension AmizadeViewController : AmizadeServiceDelegate {
    func success() {
        
        print(AutorViewModel.ge)
        
    }
    
    func failure(error: String) {
        print(error)
    }
    
    
}

/*extension AmizadeViewController : SearchTableViewCellDelegate {
    func add(name: String) {
            
    }
}*/
