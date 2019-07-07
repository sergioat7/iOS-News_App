//
//  ArticlesTableViewController.swift
//  NewsApp
//
//  Created by Aragones, Sergio (ES - Madrid) on 07/07/2019.
//  Copyright © 2019 admin. All rights reserved.
//
import UIKit

class ArticlesTableViewController: UITableViewController {
    
    var titles = [String]()
    var authors = [String]()
    var sections = [String]()
    var publishDates = [String]()
    var articleURLs = [String]()
    
    
    var articlesController: ArticlesController!
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.reuseIdentifier, for: indexPath) as? ArticleTableViewCell  else {
            fatalError("The dequeued cell is not an instance of VehicleTableViewCell.")
        }
        
        cell.setImage("t_arrow")
        cell.setTitle(titles[indexPath.row])
        cell.setAuthor(authors[indexPath.row])
        cell.setSection(sections[indexPath.row])
        cell.setPublishDate(publishDates[indexPath.row])
        cell.articleURL = articleURLs[indexPath.row]
        
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
