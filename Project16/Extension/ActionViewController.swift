//
//  ActionViewController.swift
//  Extension
//
//  Created by chams on 19/04/2019.
//  Copyright © 2019 Chams. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {

    public var pageTitle = ""
    public var pageURL = ""
    
    @IBOutlet weak var script: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        
        if let inputItem = extensionContext!.inputItems.first as? NSExtensionItem {
            if let itemProvider = inputItem.attachments?.first {
                itemProvider.loadItem(forTypeIdentifier:
                kUTTypePropertyList as String) { [unowned self] (dict, error) in
                    let itemDictionary = dict as! NSDictionary
                    let javascriptValues = itemDictionary[NSExtensionItemAttributedContentTextKey] as! NSDictionary
                    self.pageTitle = javascriptValues["title"] as! String
                    self.pageURL = javascriptValues["URL"] as! String
                    
                    DispatchQueue.main.async {
                        self.title = self.pageTitle
                    }
                }
            }
        }
    }

    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        // self.extensionContext!.completeRequest(returningItems: self.extensionContext!.inputItems, completionHandler: nil)
        let item = NSExtensionItem()
        let argument: NSDictionary = ["customJavaScript": script.text!]
        let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
        let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
        item.attachments = [customJavaScript]
        extensionContext!.completeRequest(returningItems: [item])
    }

}
