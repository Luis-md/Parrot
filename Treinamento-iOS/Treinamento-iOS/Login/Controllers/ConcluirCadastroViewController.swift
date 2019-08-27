//
//  ConcluirCadastroViewController.swift
//  Treinamento-iOS
//
//  Created by Luis_md on 27/08/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import UIKit
import Photos
import SVProgressHUD

class ConcluirCadastroViewController: UIViewController {
    
    var fullName: String!
    var userName: String!
    var email: String!
    var password: String!
    
    var imagePicker = UIImagePickerController()
    var imageImported: UIImageView?
    var imageDetail: [String : String] = [:]
    var data: Data?
    
    var service: AutenticacaoService!
    
    @IBOutlet weak var perfilPic: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.service = AutenticacaoService.init(delegate: self)
    }
    

    @IBAction func escolherFoto(_ sender: Any) {
        
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
    
    
    @IBAction func confirmarCadastro(_ sender: Any) {
        
        if let data = self.data {
            self.service.cadastroPic(mimeType: imageDetail["mimeType"] ?? "", extensao: imageDetail["mimeTypeExtension"] ?? "", fileName: imageDetail["fileName"] ?? "", data: data, userName: userName, password: password, fullName: fullName, email: email)
            } else {
            self.service.cadastroUser(nome: fullName, username: userName, email: email, password: password)
        }
    }
    
}

extension ConcluirCadastroViewController : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
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
            
            self.perfilPic.image = image
            self.perfilPic.layer.cornerRadius = self.perfilPic.frame.height/2
        }
        self.dismiss(animated: true, completion: nil)
    }
}

extension ConcluirCadastroViewController : AutenticacaoServiceDelegate {
    func success() {
        
        self.navigationController?.popViewController(animated: true)
        ScreenManager.setupInitialViewController()
    }
    
    func failure(error: String) {
        print("deu ruim")
    }
    
    
}
