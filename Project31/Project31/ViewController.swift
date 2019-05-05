//
//  ViewController.swift
//  Project31
//
//  Created by chams on 05/05/2019.
//  Copyright © 2019 Chams. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate,
UITextFieldDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var adrressBar: UITextField!
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDefaultTitle()
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addWebView))
        let delete = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteWebView))
        navigationItem.rightBarButtonItems = [delete, add]
    }
    
    func setDefaultTitle() {
        title = "Multiplebrowser"
    }
    
    @objc func addWebView() {
        let webView = WKWebView()
        webView.navigationDelegate = self
        
        stackView.addArrangedSubview(webView)
        
        let url = URL(string: "https://hackingwithswift.com")!
        webView.load(URLRequest(url: url))
    }
    
    @objc func deleteWebView() {
        
    }
    
}

