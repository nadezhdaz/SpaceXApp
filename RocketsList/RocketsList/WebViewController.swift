//
//  WebViewController.swift
//  RocketsList
//
//  Created by Nadezhda Zenkova on 19.09.2021.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    private var url: URL
    
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let configuration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.load(URLRequest(url:url))
        
        self.view.addSubview(webView)
        webView.frame = self.view.bounds
    }

}
