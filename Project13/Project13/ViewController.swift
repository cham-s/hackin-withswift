//
//  ViewController.swift
//  Project13
//
//  Created by chams on 16/04/2019.
//  Copyright © 2019 Chams. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController,
                      UIImagePickerControllerDelegate,
                      UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var intensity: UISlider!
    
    public var currentImage: UIImage!
    private var context: CIContext!
    private var currentFilter: CIFilter!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "YACIF"
        navigationItem.rightBarButtonItem =
            UIBarButtonItem(barButtonSystemItem: .add,
                            target: self,
                            action: #selector(importPicture))
        context = CIContext()
        currentFilter = CIFilter(name: "CISepiaTone")
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true)
        currentImage = image
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    @objc func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func applyProcessing() {
        
        currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey)
        
        if let cgimg =
        context.createCGImage(currentFilter.outputImage!,
                              from: currentFilter.outputImage!.extent) {
            let processedImage = UIImage(cgImage: cgimg)
            imageView.image = processedImage
        }
    }
    
    @IBAction func changeFilter(_ sender: UIButton) {
    }
    @IBAction func save(_ sender: UIButton) {
    }
    @IBAction func intensityChanged(_ sender: Any) {
        applyProcessing()
    }
}

