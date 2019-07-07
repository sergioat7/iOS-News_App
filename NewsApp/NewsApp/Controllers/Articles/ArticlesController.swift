//
//  ArticlesController.swift
//  NewsApp
//
//  Created by Aragones, Sergio (ES - Madrid) on 07/07/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class ArticlesController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    fileprivate let articlesTableViewController = ArticlesTableViewController()
    
    @IBOutlet weak var spinnerContainterView: UIView!
    @IBOutlet weak var spinnerView: SpinnerView!
    
    
    
    init(){
        super.init(nibName: "ArticlesView", bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleLabel.text = "Artículos"
        
        
        tableView.register(UINib(nibName: ArticleTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ArticleTableViewCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        articlesTableViewController.tableView = tableView
        articlesTableViewController.articlesController = self
        
        
        spinnerView.strokeColor = UIColor.negro.cgColor
        
        
        articlesTableViewController.titles.append("Android")
        articlesTableViewController.titles.append("iOS")
        articlesTableViewController.titles.append("Windows Phone")
        articlesTableViewController.titles.append("SS.OO. Inexistente")
        
        articlesTableViewController.authors.append("Google")
        articlesTableViewController.authors.append("Apple")
        articlesTableViewController.authors.append("Microsoft")
        articlesTableViewController.authors.append("Sin autor")
        
        articlesTableViewController.sections.append("Google Mobile")
        articlesTableViewController.sections.append("Apple Phones")
        articlesTableViewController.sections.append("Windows Mobile")
        articlesTableViewController.sections.append("")
        
        articlesTableViewController.publishDates.append("23/09/2008")
        articlesTableViewController.publishDates.append("29/06/2007")
        articlesTableViewController.publishDates.append("21/10/2010")
        articlesTableViewController.publishDates.append("")
        
        articlesTableViewController.articleURLs.append("https://www.google.com")
        articlesTableViewController.articleURLs.append("https://www.apple.com")
        articlesTableViewController.articleURLs.append("https://www.microsoft.com")
        articlesTableViewController.articleURLs.append("https://www.noexiste.com/")
        
        
        getArticles()
    }
    
    func getArticles(){
//        spinnerContainterView.isHidden = false
//        Session.sharedSession().sessionManager?.request(NYTimesRouter.getNews(["mostviewed","7"]))
//            .validate()
//            .responseJSON { response in
                self.spinnerContainterView.isHidden = true
//                switch(response.result){
//
//                case .success:
                    self.articlesTableViewController.tableView.reloadData()
//                    break
//
//                case .failure:
//                    break
//                }
//        }
    }
    
    func openArticle(_ articleURL: String){
        navigationController?.pushViewController(ArticleDataController(articleURL), animated: true)
    }
}
