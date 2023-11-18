//
//  UIView+Extensions.swift
//  Bankey
//
//  Created by admin on 18/11/2023.
//

import UIKit

extension UIView {
    func addRoundedCorner(radius: CGFloat){
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
    }
}
