//
//  DetailViewController.swift
//  Challenge1
//
//  Created by chams on 02/04/2019.
//  Copyright © 2019 Chams. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    public var selectedImage: String?

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        imageView.image = UIImage(named: selectedImage!)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                           target: self, action: #selector(sharedTapped))

        // Do any additional setup after loading the view.
    }
    
    @objc func sharedTapped() {
        let vc = UIActivityViewController(
            activityItems: [selectedImage!,
                            imageView.image!],
                            applicationActivities: [])
        
        present(vc, animated: true)
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
