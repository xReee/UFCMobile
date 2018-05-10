//
//  Extensions.swift
//  UFCMobile
//
//  Created by Renata on 07/05/18.
//  Copyright © 2018 Renata. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?,
                left: NSLayoutXAxisAnchor?,
                bottom: NSLayoutYAxisAnchor?,
                right: NSLayoutXAxisAnchor?,
                paddingTop: CGFloat, paddingLeft: CGFloat,
                paddingBottom: CGFloat, paddingRight: CGFloat,
                widht: CGFloat, height: CGFloat){
        
        if let top = top {
            self.topAnchor.constraint(equalTo:top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: paddingTop).isActive = true
        }
    }
    
    func addConstraintsWithFixedConstant(targetView : UIView, referenceView : UIView, attributes : NSLayoutAttribute..., multipliers : [CGFloat]){
        if multipliers.count == attributes.count {
            for (index, attribute) in  attributes.enumerated() {
                addConstraint(NSLayoutConstraint.init(item: targetView, attribute: attribute, relatedBy: .equal, toItem: targetView, attribute: attribute, multiplier: multipliers[index], constant: 1))
            }
        }
        
        
//        var viewsDictionary = [String: UIView]()
//        for (index, view) in views.enumerated() {
//            let key = "v\(index)"
//            view.translatesAutoresizingMaskIntoConstraints = false
//            viewsDictionary[key] = view
//        }

        
//view.addConstraint(NSLayoutConstraint.init(item: <#T##Any#>, attribute: <#T##NSLayoutAttribute#>, relatedBy: <#T##NSLayoutRelation#>, toItem: <#T##Any?#>, attribute: <#T##NSLayoutAttribute#>, multiplier: <#T##CGFloat#>, constant: <#T##CGFloat#>))
    }
    
    
}
