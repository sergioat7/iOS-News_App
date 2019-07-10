//
//  ArticlesTableViewController.swift
//  NewsApp
//
//  Created by Aragones, Sergio (ES - Madrid) on 07/07/2019.
//  Copyright © 2019 admin. All rights reserved.
//
import UIKit

class ArticlesTableViewController: UITableViewController {
    
    var articles = [Article]()
    
    
    var articlesController: ArticlesController!
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.reuseIdentifier, for: indexPath) as? ArticleTableViewCell  else {
            fatalError("The dequeued cell is not an instance of VehicleTableViewCell.")
        }
        
        cell.setImage(articles[indexPath.row].media?[0].mediaMetadata?[0].url)
        cell.setTitle(articles[indexPath.row].title)
        cell.setAuthor(articles[indexPath.row].author)
        cell.setSection(articles[indexPath.row].section)
        cell.setPublishDate(articles[indexPath.row].publishDate)
        cell.articleURL = articles[indexPath.row].url ?? "https://www.-.com/"
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return calculateHeight(selectedIndexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let cell = self.tableView.cellForRow(at: indexPath) as! ArticleTableViewCell
        articlesController.openArticle(cell.articleURL)
    }
    
    func calculateHeight(selectedIndexPath: IndexPath) -> CGFloat {
        if let cell = self.tableView.cellForRow(at: selectedIndexPath) as? ArticleTableViewCell {
            cell.titleLabel.frame = Utilidades.labelFrame(label: cell.titleLabel)
            cell.authorLabel.frame = Utilidades.labelFrame(label: cell.authorLabel)
            cell.sectionLabel.frame = Utilidades.labelFrame(label: cell.sectionLabel)
            cell.publishDateLabel.frame = Utilidades.labelFrame(label: cell.publishDateLabel)
            return 25 + cell.titleLabel.frame.size.height + cell.authorLabel.frame.size.height + cell.sectionLabel.frame.size.height + cell.publishDateLabel.frame.size.height
        }
        else {
            return 100
        }
    }
}
