//
//  ArticleDataController.swift
//  NewsApp
//
//  Created by Aragones, Sergio (ES - Madrid) on 07/07/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import WebKit

class ArticleDataController: UIViewController {
    
    
    @IBOutlet weak var spinnerContainerView: UIView!
    @IBOutlet weak var spinnerView: SpinnerView!
    
    var webView: WKWebView!
    var articleURL = ""
    
    
    init(){
        super.init(nibName: "ArticleDataView", bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    convenience init(_ articleURL: String) {
        self.init()
        self.articleURL = articleURL
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleLabel.text = " "
        
        spinnerView.strokeColor = UIColor.negro.cgColor
        
        let webView = WKWebView(frame: .zero)
        webView.navigationDelegate = self
        
        view.addSubview(webView)
        view.sendSubviewToBack(webView)
        
        let layoutGuide = view.safeAreaLayoutGuide
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: layoutGuide.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true
        
        if let url = URL(string: articleURL) {
            webView.load(URLRequest(url: url))
        }
    }
}
extension ArticleDataController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        navigationItem.titleLabel.text = webView.title
        spinnerContainerView.isHidden = true
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        let alert = UIAlertController(title: "Error", message: "Hubo un error al cargar la página, por favor vuelve a intentarlo.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
        spinnerContainerView.isHidden = true
    }
}
