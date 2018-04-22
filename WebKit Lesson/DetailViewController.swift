//
//  DetailViewController.swift
//  WebKit Lesson
//
//  Created by Denis Bystruev on 22.04.2018.
//  Copyright © 2018 Denis Bystruev. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: String!
    var titleItem: String = ""
    var signatureCount: Int = 0
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard detailItem != nil else { return }
        
        if let body = detailItem {
            let html = """
                <html>
                    <head>
                    <meta name="viewport" content="width=device-width, initial-scale=1">
                    <style> body { font-size: 150%; } </style>
                    </head>
                    <body>
                        <h2>\(titleItem)</h2>
                        <h3>Signature Count: \(signatureCount)</h3>
                        \(body)
                    </body>
                </html>
            """
            webView.loadHTMLString(html, baseURL: nil)
        }
    }

}
