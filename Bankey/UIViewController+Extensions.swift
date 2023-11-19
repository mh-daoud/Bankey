//
//  UIViewController+Extensions.swift
//  Bankey
//
//  Created by admin on 19/11/2023.
//

import UIKit

extension UIViewController {
    func setStatusBar() {
        let statusBarSize = UIApplication.shared.statusBarFrame.size
        let frame = CGRect(origin: .zero, size: statusBarSize)
        let statusBarView = UIView(frame: frame)
        
        statusBarView.backgroundColor = Theme.appColor
        view.addSubview(statusBarView)
    }
    
    func setTabarImage(imageName: String, title: String) {
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let tabImage = UIImage(systemName: imageName, withConfiguration: configuration)
        tabBarItem = UITabBarItem(title: title, image: tabImage, tag: 0)
    }
}
