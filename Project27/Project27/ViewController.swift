//
//  ViewController.swift
//  Project27
//
//  Created by chams on 01/05/2019.
//  Copyright © 2019 Chams. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var currentDrawType = 0
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawRectangle()
    }
    
    func drawRectangle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512,
                                                            height: 512))
        
        let img = renderer.image { ctx in
            let rectangle = CGRect(x: 5, y: 5, width: 502, height: 502)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
            
        }
        
        imageView.image = img
    }
    
    func drawCircle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512,
                                                            height: 512))
        
        let img = renderer.image { ctx in
            let rectangle = CGRect(x: 5, y: 5, width: 502, height: 502)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
            
        }
        
        imageView.image = img
    }
    
    
    @IBAction func redrawTapped(_ sender: Any) {
        currentDrawType += 1
        
        if currentDrawType > 5 {
            currentDrawType = 0
        }
        
        switch currentDrawType {
        case 0:
            drawRectangle()
        case 1:
            drawCircle()
        default:
            break
        }
    }
}

