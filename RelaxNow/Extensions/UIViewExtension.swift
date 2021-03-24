//
//  UIViewExtension.swift
//  RelaxNow
//
//  Created by Pritrum on 11/03/21.
//

import UIKit
extension UIView{
    func addShadow(offset: CGSize, radius: CGFloat, color: UIColor, opacity: Float, cornerRadius: CGFloat? = nil) {
        let shadowSize : CGFloat = 10.0
       
        
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
        self.layer.shadowColor = color.cgColor
       
        if let r = cornerRadius {
//            self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: r).cgPath
            
            self.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: -shadowSize / 2,
                                                               y: -shadowSize / 2,
                                                               width: self.frame.size.width + shadowSize,
                                                               height: self.frame.size.height + shadowSize), cornerRadius: r).cgPath
        }else{
            self.layer.shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                               y: -shadowSize / 2,
                                                               width: self.frame.size.width + shadowSize,
                                                               height: self.frame.size.height + shadowSize)).cgPath

        }
        
    }
    
    func addShadowOnAllSides() {
        let shadowSize : CGFloat = 10.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: self.frame.size.width + shadowSize,
                                                   height: self.frame.size.height + shadowSize))
        self.layer.masksToBounds = false
        if #available(iOS 12.0, *) {
            self.layer.shadowColor = self.traitCollection.userInterfaceStyle == .dark ? UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.3).cgColor  : UIColor(white: 0.0, alpha: 0.3).cgColor
        } else {
            // Fallback on earlier versions
            self.layer.shadowColor = UIColor(white: 0.0, alpha: 0.3).cgColor
        }
        //UIColor.RGB(red: 170.0, green: 170.0, blue: 170.0, alpha: 0.5).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 10.0
        self.layer.shadowPath = shadowPath.cgPath
    }
}
