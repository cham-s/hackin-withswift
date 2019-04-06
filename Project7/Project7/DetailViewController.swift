//
//  DetailViewController.swift
//  Project7
//
//  Created by chams on 05/04/2019.
//  Copyright © 2019 Chams. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    private var webView: WKWebView!
    public var detailItem: Petition?
    
    override func loadView() {
        
        guard let detailItem = detailItem else { return }
        webView = WKWebView()
        view = webView
        
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-
        scale=1">
        <style> body { font-size: 150%; } </style>
        </head>
        <body>
        \(detailItem.body)
        </body>
        </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

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
