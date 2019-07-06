//
//  NavigationBar.swift
//  NewsApp
//
//  Created by Aragones, Sergio (ES - Madrid) on 06/07/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import Material

extension NavigationBar {
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        for view in subviews {
            view.layoutMargins = .zero
        }
    }
}
