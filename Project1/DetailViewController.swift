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

        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
