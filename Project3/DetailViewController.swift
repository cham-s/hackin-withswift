//
//  DetailViewController.swift
//  Project1
//
//  Created by chams on 29/03/2019.
//  Copyright © 2019 Chams. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet public weak var imageView: UIImageView!
    public var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
        
        title = selectedImage
        navigationItem.largeTitleDisplayMode = .never

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return navigationController?.hidesBarsOnTap ?? false
    }
}
