//
//  ViewController.swift
//  Project4
//
//  Created by chams on 03/04/2019.
//  Copyright © 2019 Chams. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    private var webView: WKWebView!
    private var progessView: UIProgressView!
    public var websites = ["apple.com", "hackingwithswift.com"]
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://www.hackingwithswift.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(openTapped))
        
        progessView = UIProgressView(progressViewStyle: .default)
        progessView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progessView)
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                     target: nil,
                                     action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh,
                                      target: webView,
                                      action: #selector(webView.reload))
        toolbarItems = [progressButton, spacer, refresh]
        
        navigationController?.isToolbarHidden = false
        
        webView.addObserver(self,
                            forKeyPath: #keyPath(WKWebView.estimatedProgress),
                            options: .new,
                            context: nil)
    }
    
    @objc func openTapped() {
        let ac = UIAlertController(title: "Open page...",
                                   message: nil,
                                   preferredStyle: .actionSheet)
        websites.forEach { website in
            ac.addAction(UIAlertAction(title: website,
                                       style: .default,
                                       handler: openPage))
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem =
            self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
        
    }
    
    func openPage(action: UIAlertAction) {
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progessView.progress = Float(webView.estimatedProgress)
        }
    }
    
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url?.host {
            for website in websites {
                if host.contains(website) {
                    decisionHandler(.allow)
                    return
                }
            }
        }
        decisionHandler(.cancel)
    }
}
