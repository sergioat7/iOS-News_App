//
//  Article.swift
//  NewsApp
//
//  Created by Aragones, Sergio (ES - Madrid) on 10/07/2019.
//  Copyright © 2019 admin. All rights reserved.
//
import Foundation
import ObjectMapper

class Article: Mappable {
    
    var title: String?
    var author: String?
    var section: String?
    var publishDate: String?
    var media: [Media]?
    var url: String?
    
    init(){}
    
    required init?(map: Map){
    }
    
    func mapping(map: Map){
        self.title <- map["title"]
        self.author <- map["byline"]
        self.section <- map["section"]
        self.publishDate <- map["published_date"]
        self.media <- map["media"]
        self.url <- map["url"]
    }
    
}



