//
//  RoundedButton.swift
//  NewsApp
//
//  Created by Aragones, Sergio (ES - Madrid) on 06/07/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                self.backgroundColor = self.backgroundColor?.withAlphaComponent(0.8)
            }
            else {
                UIView.animate(
                    withDuration: 0.2,
                    delay: 0,
                    usingSpringWithDamping: 1,
                    initialSpringVelocity: 0,
                    options: [.beginFromCurrentState, .allowUserInteraction],
                    animations: { () -> Void in
                        self.backgroundColor = UIColor.black
                },
                    completion: nil
                )
            }
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                backgroundColor = UIColor.black
                layer.shadowRadius = 1
            }
            else {
                backgroundColor = UIColor.gray
                layer.shadowRadius = 0
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setUp()
    }
    
    func setUp() {
        titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLabel?.textAlignment = NSTextAlignment.center
        
        setTitleColor(UIColor.white, for: UIControl.State())
        titleLabel?.font = UIFont.robotoBold13
        if layer.frame.height == 0.0 {
            layer.cornerRadius = 24
        }
        else {
            layer.cornerRadius = layer.frame.height / 2
        }
        
        self.setTitle((self.currentTitle)?.uppercased(), for: UIControl.State())
        self.backgroundColor = UIColor.black
    }
    
}
