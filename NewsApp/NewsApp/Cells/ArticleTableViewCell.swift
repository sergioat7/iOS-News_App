//
//  ArticleTableViewCell.swift
//  NewsApp
//
//  Created by Aragones, Sergio (ES - Madrid) on 07/07/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var publishDateLabel: UILabel!
    
    
    static var reuseIdentifier: String = "ArticleTableViewCell"
    var articleURL = ""

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func setImage(_ imageURL: String?) {
        Utilidades.cargarImagen(imageURL, mainImageView)
    }
    func setTitle(_ text: String?) {
        if let _ = text {
            titleLabel.attributedText = NSAttributedString(string: text!, attributes: [.font: UIFont.robotoBold11, .foregroundColor: UIColor.blackFive])
        }
        else {
            titleLabel.text = ""
        }
    }
    func setAuthor(_ text: String?) {
        if let _ = text {
            authorLabel.attributedText = NSAttributedString(string: text!, attributes: [.font: UIFont.robotoMedium11, .foregroundColor: UIColor.blackFive])
        }
        else {
            authorLabel.text = ""
        }
    }
    func setSection(_ text: String?) {
        if let _ = text {
            sectionLabel.attributedText = NSAttributedString(string: text!, attributes: [.font: UIFont.robotoRegular11, .foregroundColor: UIColor.blackFive])
        }
        else {
            sectionLabel.text = ""
        }
    }
    func setPublishDate(_ text: String?) {
        if let _ = text {
            publishDateLabel.attributedText = NSAttributedString(string: text!, attributes: [.font: UIFont.robotoLight11, .foregroundColor: UIColor.blackFive])
        }
        else {
            publishDateLabel.text = ""
        }
    }
}
