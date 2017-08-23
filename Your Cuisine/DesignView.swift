//
//  DesignView.swift
//  Your Cuisine
//
//  Created by Make school on 8/15/17.
//  Copyright © 2017 Make school. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable class DesignView : UIView {
    @IBInspectable var cornerRadius : CGFloat = 0
    @IBInspectable var shadowColor : UIColor? = UIColor.black
    
    @IBInspectable var shadowOffWidth : Int = 0
    @IBInspectable var shadowOffHeight : Int = 1
    @IBInspectable var shadowOpacity : Float = 0.2
    
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffWidth, height: shadowOffHeight)
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = shadowOpacity
    }
    
}
