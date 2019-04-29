//
//  ViewController.swift
//  Project25
//
//  Created by chams on 29/04/2019.
//  Copyright © 2019 Chams. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UINavigationControllerDelegate,
                      UIImagePickerControllerDelegate {
    
    private var images: [UIImage] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Selfie Share"
        navigationItem.rightBarButtonItem =
            UIBarButtonItem(barButtonSystemItem: .camera, target: self,
                            action: #selector(importPicture))
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) ->
        UICollectionViewCell {
        
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "ImageView", for: indexPath)
            if let imageView = cell.viewWithTag(1000) as? UIImageView {
               imageView.image = images[indexPath.item]
            }
            return cell
    }
    
    @objc func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info:
        [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true)
        images.insert(image, at: 0)
        collectionView?.reloadData()
    }
}

