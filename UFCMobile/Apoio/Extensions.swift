//
//  Extensions.swift
//  UFCMobile
//
//  Created by Renata on 07/05/18.
//  Copyright © 2018 Renata. All rights reserved.
//

import Foundation
import UIKit

//extensões aqui

extension UIViewController {
    ///keyboard function
    // Move the text field in a pretty animation!
    func moveTextField(_ textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
}


extension UIColor {
     static func verdePrincipal() -> UIColor{
        return UIColor(red: 11/255, green: 136/255, blue: 64/255, alpha: 1)
    }
}

extension UITableView {
    func becomeFirstResponderTextField() {
        outer: for cell in visibleCells {
            for view in cell.contentView.subviews {
                if let textfield = view as? UITextField {
                    textfield.becomeFirstResponder()
                    break outer
                }
            }
        }
    }
}

