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
        
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(intensity.value * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(intensity.value * 10, forKey: kCIInputScaleKey)
        }
        if inputKeys.contains(kCIInputCenterKey) {
            currentFilter.setValue(CIVector(x: currentImage.size.width / 2,
                                            y: currentImage.size.height / 2),
                                   forKey: kCIInputCenterKey)
        }
        
        
        if let cgimg =
        context.createCGImage(currentFilter.outputImage!,
                              from: currentFilter.outputImage!.extent) {
            let processedImage = UIImage(cgImage: cgimg)
            imageView.image = processedImage
        }
    }
    
    func setFilter(action: UIAlertAction) {
        guard currentImage != nil else { return }
        
        currentFilter = CIFilter(name: action.title!)
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    @IBAction func changeFilter(_ sender: UIButton) {
        let ac = UIAlertController(title: "Choose filter",
                                   message: nil,
                                   preferredStyle: .actionSheet)
        let filters = ["CIBumpDistortion", "CIGaussianBlur", "CIPixellate",
                       "CISepiaTone", "CITwirlDistortion", "CIUnsharpMask",
                       "CIVignette"]
        filters.forEach { filter in
            ac.addAction(UIAlertAction(title: filter, style: .default,
                                       handler: setFilter))
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    @IBAction func save(_ sender: UIButton) {
    }
    @IBAction func intensityChanged(_ sender: Any) {
        applyProcessing()
    }
}

