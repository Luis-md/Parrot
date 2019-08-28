//
//  EditPerfilViewController.swift
//  Treinamento-iOS
//
//  Created by Luis_md on 05/08/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import UIKit
import Kingfisher
import Photos

protocol EditPerfilDelegate {
    func updtProfile(name: String, password: String)
}

class EditPerfilViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var profilePic: UIImageView!
    
    var perfil: PerfilView!
    
    var imagePicker = UIImagePickerController()
    var imageImported: UIImageView?
    var imageDetail: [String : String] = [:]
    var data: Data?
    
    
    
    var delegate: EditPerfilDelegate!
    var perfilService: PerfilService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        perfilService = PerfilService(delegate: self)
        self.profilePic.layer.cornerRadius = self.profilePic.frame.height / 2
        self.profilePic.kf.setImage(with: self.perfil?.autor.urlImg)
        self.password.placeholder = "Nova senha"
        self.name.placeholder = "Nome"


       /* self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Concluir", style: .done, target: self, action: #selector(method(for:)))*/
    }
    
    @IBAction func updtInfo(_ sender: Any) {
        
        if let name = name.text,
           let password = password.text,
           !name.isEmpty && !password.isEmpty {
            
            if let data = self.data {
                self.perfilService.updtPerfilPic(mimeType: imageDetail["mimeType"] ?? "", extensao: imageDetail["mimeTypeExtension"] ?? "", fileName: imageDetail["fileName"] ?? "", data: data, name: name, password: password)
            } else {
                self.perfilService.updtPerfil(name: name, password: password)
            }
        }
    }
    
    @IBAction func logout(_ sender: Any) {
        
        perfilService.logoutPerfil()
    }
    
    
    @IBAction func profilePic(_ sender: Any) {
        
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
    
}

extension EditPerfilViewController: perfilDelegate {
    func success(type: ResponseType) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func failure(error: String) {
        print(error)
    }
    
    
}


extension EditPerfilViewController : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
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
            
            self.profilePic.image = image
            self.profilePic.layer.cornerRadius = self.profilePic.frame.height/2            
            
        }
        self.dismiss(animated: true, completion: nil)
    }
}

