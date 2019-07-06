//
//  UIViewController.swift
//  NewsApp
//
//  Created by Aragones, Sergio (ES - Madrid) on 06/07/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func hideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboardFunc))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboardFunc(){
        view.endEditing(true)
    }
    
    func isControllerVisible() -> Bool {
        return self.view.window != nil
    }
}
