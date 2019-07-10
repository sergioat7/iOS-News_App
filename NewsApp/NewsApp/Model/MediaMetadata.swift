//
//  MediaMetadata.swift
//  NewsApp
//
//  Created by Aragones, Sergio (ES - Madrid) on 10/07/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import ObjectMapper

class MediaMetadata: Mappable {
    
    var url: String?
    var height: Int!
    var width: Int!
    
    init(){}
    
    required init?(map: Map){
    }
    
    func mapping(map: Map){
        self.url <- map["url"]
        self.height <- map["height"]
        self.width <- map["width"]
    }
    
}



