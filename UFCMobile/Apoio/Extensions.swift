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
    
    func viewSize(_ qualDeles: String) -> CGFloat{
        if qualDeles == "height" {
            return self.view.frame.height
        } else {
            return self.view.frame.width
        }
    }
    
}

extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ quality: JPEGQuality) -> Data? {
        return UIImageJPEGRepresentation(self, quality.rawValue)
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

