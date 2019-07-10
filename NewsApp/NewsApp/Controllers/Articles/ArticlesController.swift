//
//  ArticlesController.swift
//  NewsApp
//
//  Created by Aragones, Sergio (ES - Madrid) on 07/07/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import ObjectMapper


class ArticlesController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    fileprivate let articlesTableViewController = ArticlesTableViewController()
    
    @IBOutlet weak var spinnerContainterView: UIView!
    @IBOutlet weak var spinnerView: SpinnerView!
    
    var type: String!
    var period: String!
    var shareType: String?
    
    
    init(){
        super.init(nibName: "ArticlesView", bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    convenience init(_ type: String, _ period: String, _ shareType: String?) {
        self.init()
        self.type = type
        self.period = period
        self.shareType = shareType
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
        
        
        getArticles()
    }
    
    func getArticles(){
        let parameters: [String : Any?] = [
            "type": type,
            "period": period,
            "shareType": shareType
        ]
        spinnerContainterView.isHidden = false
        Session.sharedSession().sessionManager?.request(NYTimesRouter.getNews(parameters))
            .validate()
            .responseJSON { response in
                switch(response.result){

                case .success:
                    if let json = response.result.value as? [String : Any], let jsonArray = json["results"] as? [[String : Any]], jsonArray.count > 0 {
                        let articles: Array<Article> = Mapper<Article>().mapArray(JSONArray: jsonArray)
                        self.articlesTableViewController.articles = articles
                    }
                    break

                case .failure:
                    break
                }
                
                self.spinnerContainterView.isHidden = true
                self.articlesTableViewController.tableView.reloadData()
        }
    }
    
    func openArticle(_ articleURL: String){
        navigationController?.pushViewController(ArticleDataController(articleURL), animated: true)
    }
}
