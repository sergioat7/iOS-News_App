//
//  PickOptionButton.swift
//  NewsApp
//
//  Created by Aragones, Sergio (ES - Madrid) on 06/07/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}


class PickOptionButton: UIButton {
    
    fileprivate let textLabel = UILabel()
    fileprivate let arrowImageView = UIImageView()
    
    fileprivate let underlineLayer = CALayer()
    
    var title: String? {
        set {
            textLabel.text = newValue
        }
        get {
            return textLabel.text
        }
    }
    
    var isShowingError: Bool {
        return _errorLabel?.text?.count > 0
    }
    fileprivate var _errorLabel: UILabel?
    fileprivate var errorLabel: UILabel {
        if _errorLabel == nil {
            _errorLabel = UILabel()
            _errorLabel?.translatesAutoresizingMaskIntoConstraints = false
            _errorLabel?.numberOfLines = 0
            _errorLabel?.textColor = UIColor(red: 196/255, green: 44/255, blue: 26/255, alpha: 1)
            _errorLabel?.font = UIFont.robotoLight11
            _errorLabel?.frame = CGRect(x: 4, y: 52, width: frame.width-8, height: 0)
            _errorLabel?.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 900), for: .vertical)
            
            addSubview(_errorLabel!)
            
            addConstraints([
                NSLayoutConstraint(item: _errorLabel!, attribute: .top, relatedBy: .equal,
                                   toItem: textLabel, attribute: .bottom, multiplier: 1, constant: 12),
                NSLayoutConstraint(item: _errorLabel!, attribute: .top, relatedBy: .greaterThanOrEqual,
                                   toItem: self, attribute: .top, multiplier: 1, constant: 52),
                NSLayoutConstraint(item: _errorLabel!, attribute: .leading, relatedBy: .equal,
                                   toItem: self, attribute: .leading, multiplier: 1, constant: 4),
                NSLayoutConstraint(item: _errorLabel!, attribute: .trailing, relatedBy: .equal,
                                   toItem: self, attribute: .trailing, multiplier: 1, constant: -4),
                NSLayoutConstraint(item: _errorLabel!, attribute: .bottom, relatedBy: .equal,
                                   toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
                ]
            )
        }
        
        return _errorLabel!
    }
    
    override var isEnabled: Bool {
        didSet {
            let image = isEnabled ? UIImage(named: "t_arrow")?.withRenderingMode(.alwaysTemplate) : nil
            
            arrowImageView.image = image
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: isHighlighted ? 0 : 0.3, animations: { () -> Void in
                self.textLabel.alpha = self.isHighlighted ? 0.6 : 1
                self.arrowImageView.alpha = self.isHighlighted ? 0.6 : 1
            })
        }
    }
    
    
    func hideError() {
        showError(nil)
    }
    
    func showError(_ error: String?) {
        guard _errorLabel?.text != error else {
            return
        }
        
        if let error = error, error.count > 0 {
            self.errorLabel.text = error
            underlineLayer.backgroundColor = UIColor(red: 196/255, green: 44/255, blue: 26/255, alpha: 1).cgColor
            
            // Shake
            let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
            animation.duration = 0.3
            animation.values = [-10.0, 10.0, -8.0, 8.0, -6.0, 6.0, -4.0, 4.0, 0.0 ]
            layer.add(animation, forKey: "shake")
        }
        else {
            self._errorLabel?.text = nil
            underlineLayer.backgroundColor = UIColor(white: 191/255, alpha: 1).cgColor
        }
        
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 0,
            options: [.beginFromCurrentState, .allowUserInteraction],
            animations: { () -> Void in
                self.superview?.layoutIfNeeded()
        },
            completion: nil
        )
    }
    
    override func setTitle(_ title: String?, for state: UIControl.State) {
        textLabel.text = title
    }
    
    override func setImage(_ image: UIImage?, for state: UIControl.State) {
        arrowImageView.image = image
    }
    
    // MARK: Set up
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setUp()
    }
    
    func setUp() {
        tintColor = UIColor(white: 158/255, alpha: 1)
        textLabel.textColor = UIColor(white: 158/255, alpha: 1)
        textLabel.font = UIFont.robotoMedium16
        textLabel.textAlignment = .left
        textLabel.text = self.title(for: UIControl.State())
        textLabel.numberOfLines = 0
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 800), for: .horizontal)
        textLabel.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 950), for: .vertical)
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        arrowImageView.setContentHuggingPriority(UILayoutPriority(rawValue: 800), for: .horizontal)
        arrowImageView.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 900), for: .horizontal)
        arrowImageView.contentMode = .scaleAspectFit
        arrowImageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        
        titleLabel?.removeFromSuperview()
        imageView?.removeFromSuperview()
        
        let minHeight = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .greaterThanOrEqual,
                                           toItem: nil, attribute: .height, multiplier: 1, constant: 48)
        
        addConstraint(minHeight)
        
        addSubview(textLabel)
        addSubview(arrowImageView)
        
        let textBottomConstraint = NSLayoutConstraint(item: textLabel, attribute: .bottom, relatedBy: .equal,
                                                      toItem: self, attribute: .bottom, multiplier: 1, constant: -8)
        textBottomConstraint.priority = UILayoutPriority(rawValue: 700)
        
        addConstraints([
            NSLayoutConstraint(item: textLabel, attribute: .top, relatedBy: .equal,
                               toItem: self, attribute: .top, multiplier: 1, constant: 8),
            NSLayoutConstraint(item: textLabel, attribute: .leading, relatedBy: .equal,
                               toItem: self, attribute: .leading, multiplier: 1, constant: 8),
            
            NSLayoutConstraint(item: arrowImageView, attribute: .centerY, relatedBy: .equal,
                               toItem: textLabel, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: arrowImageView, attribute: .trailing, relatedBy: .equal,
                               toItem: self, attribute: .trailing, multiplier: 1, constant: -8),
            
            NSLayoutConstraint(item: textLabel, attribute: .trailing, relatedBy: .equal,
                               toItem: arrowImageView, attribute: .leading, multiplier: 1, constant: -6),
            
            NSLayoutConstraint(item: textLabel, attribute: .bottom, relatedBy: .lessThanOrEqual,
                               toItem: self, attribute: .bottom, multiplier: 1, constant: -8),
            textBottomConstraint
            ]
        )
        
        
        layer.addSublayer(underlineLayer)
        underlineLayer.backgroundColor = UIColor(white: 191/255, alpha: 1).cgColor
        
        // Call enabled's didSet
        let enabled = self.isEnabled
        self.isEnabled = enabled
        
        setTitle(currentTitle, for: UIControl.State())
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let underlineWidth: CGFloat = isShowingError ? 2 : 1
        
        underlineLayer.frame = CGRect(
            x: 0,
            y: textLabel.frame.height + 16 - underlineWidth,
            width: frame.width,
            height: underlineWidth
        )
    }
    
}
