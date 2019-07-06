//
//  Utilidades.swift
//  NewsApp
//
//  Created by Aragones, Sergio (ES - Madrid) on 06/07/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class Utilidades {
    static var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.locale = Locale(identifier: "es")
        dateFormatter.timeZone = NSTimeZone.local
        return dateFormatter
    }()
    
    static var numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = "€"
        numberFormatter.minimumIntegerDigits = 1
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.locale = Locale(identifier: "es")
        return numberFormatter
    }()
    
    static func substring(_ data: String, _ inicio: Int, _ final: Int) -> String {
        if data.count >= final && final >= inicio && inicio>=0 {
            return String(data[data.index(data.startIndex, offsetBy: inicio)..<data.index(data.startIndex, offsetBy: final)])
        }
        return data
    }
    
    static func areStringsEqual(_ str1: String?, _ str2: String?) -> Bool {
        return ((str1 == nil && str2 == nil) || (str1 == nil && str2 == "") || (str1 == "" && str2 == nil) || (str1 != nil && str2 != nil && str1!.caseInsensitiveCompare(str2!) == .orderedSame))
    }
    
    static func getThisMonthStart(_ fecha: Date) -> Date? {
        let components = Calendar.current.dateComponents([.year, .month], from: fecha)
        return Calendar.current.date(from: components)!
    }
    
    static func getThisMonthEnd(_ fecha: Date) -> Date? {
        let components:NSDateComponents = Calendar.current.dateComponents([.year, .month], from: fecha) as NSDateComponents
        components.month += 1
        components.day = 1
        components.day -= 1
        return Calendar.current.date(from: components as DateComponents)!
    }
    
    static func getDateFromString(_ date: String, _ mask: String) -> Date? {
        let dateFormatter = Utilidades.dateFormatter
        dateFormatter.dateFormat = mask
        return dateFormatter.date(from: date)
    }
    
    static func getStringFromDate(_ date: Date, _ mask: String) -> String {
        let dateFormatter = Utilidades.dateFormatter
        dateFormatter.dateFormat = mask
        return dateFormatter.string(from: date)
    }
    
    static func createLoading() -> UIView {
        let spinnerView = SpinnerView()
        spinnerView.frame = CGRect(x: 5, y: 5, width: 30, height: 30)
        spinnerView.strokeColor = UIColor.tealBlue.cgColor
        let v = UIView(frame: spinnerView.frame)
        v.addSubview(spinnerView)
        return v
    }
    
    static func createGradientLayer(_ initColor: CGColor, _ endColor: CGColor, _ initLocation: NSNumber, _ endLocation: NSNumber, _ frame: CGRect) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [initColor, endColor]
        gradientLayer.locations = [initLocation, endLocation]
        gradientLayer.frame = frame
        gradientLayer.needsDisplayOnBoundsChange = true
        return gradientLayer
    }
    
    static func createMarginConstraints(_ parentView: UIView, _ childView: UIView) -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        let rightConstraint = NSLayoutConstraint(item: childView, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
        constraints.append(rightConstraint)
        let leftConstraint = NSLayoutConstraint(item: childView, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
        constraints.append(leftConstraint)
        let topConstraint = NSLayoutConstraint(item: childView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)
        constraints.append(topConstraint)
        let bottomConstraint = NSLayoutConstraint(item: childView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
        constraints.append(bottomConstraint)
        return constraints
    }
    
    static func createCenterConstraints(_ parentView: UIView, _ childView: UIView) -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        let centerXConstraint = NSLayoutConstraint(item: childView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        constraints.append(centerXConstraint)
        let centerYConstraint = NSLayoutConstraint(item: childView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        constraints.append(centerYConstraint)
        return constraints
    }
    
    static func getToolbarButton(_ title: String) -> UIBarButtonItem {
        var customButton: UIButton!
        if #available(iOS 11.0, *) {
            customButton = UIButton.init(type: UIButton.ButtonType.custom)
        }
        else {
            customButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 35))
        }
        customButton.setTitle(title, for: .normal)
        customButton.setTitleColor(UIColor.tealBlue, for: .normal)
        return UIBarButtonItem.init(customView: customButton)
    }
    
    static func cargarImagen(_ imageUrl: String?, _ imageView: UIImageView) {
        if imageUrl != nil && imageUrl != "" {
            let url = URL(string: imageUrl!)!
            imageView.sd_setImage(with: url, completed: { (image, error, sdImageCacheType, url) in
                if let _ = image {
                    imageView.image = image
                    imageView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: imageView, attribute: .height, multiplier: image!.width/image!.height, constant: 0))
                }
            })
        }
        else {
            imageView.image = nil
        }
    }
    
    static func cargarImagenRedimensionando(_ imageUrl: String?, _ imageView: UIImageView, _ container: UIView, _ scale: CGFloat) {
        if imageUrl != nil && imageUrl != "" {
            let url = URL(string: imageUrl!)!
            imageView.sd_setImage(with: url, completed: { (image, error, sdImageCacheType, url) in
                if let _ = image {
                    imageView.image = image!.resizeImageKeepingRatio(container.frame.width, container.frame.height, scale)
                    imageView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: imageView, attribute: .height, multiplier: image!.width/image!.height, constant: 0))
                }
            })
        }
        else {
            imageView.image = nil
        }
    }
    
    static func labelFrame(label: UILabel) -> CGRect {
        label.numberOfLines = 0
        var labelFrame = label.frame
        let maxSize = CGSize.init(width: label.frame.size.width, height: CGFloat.greatestFiniteMagnitude)
        let requiredSize = label.sizeThatFits(maxSize)
        labelFrame.size.height = requiredSize.height
        return labelFrame
    }
    
    static func textViewFrame(textView: UITextView) -> CGRect {
        var textViewFrame = textView.frame
        let maxSize = CGSize.init(width: textView.frame.size.width, height: CGFloat.greatestFiniteMagnitude)
        let requiredSize = textView.sizeThatFits(maxSize)
        textViewFrame.size.height = requiredSize.height
        return textViewFrame
    }
    
    static func degrees2Radians(degrees: Double) -> CGFloat {
        return CGFloat( degrees * .pi / 180)
    }
}
