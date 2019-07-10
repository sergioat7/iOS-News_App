//
//  Media.swift
//  NewsApp
//
//  Created by Aragones, Sergio (ES - Madrid) on 10/07/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import ObjectMapper

class Media: Mappable {
    
    var type: String?
    var mediaMetadata: [MediaMetadata]?
    
    init(){}
    
    required init?(map: Map){
    }
    
    func mapping(map: Map){
        self.type <- map["type"]
        self.mediaMetadata <- map["media-metadata"]
    }
    
}



