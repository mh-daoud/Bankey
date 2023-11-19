//
//  MainViewController.swift
//  Bankey
//
//  Created by admin on 19/11/2023.
//

import UIKit

class MainViewController : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTabBar()
    }
    
    func setupViews(){
        let summaryVC = AccountSummaryViewController()
        let moveMoneyVC = MoveMoneyViewController()
        let moreVC = MoreViewController()
        
        summaryVC.setTabarImage(imageName: "list.dash.header.rectangle", title: "Summary")
        moveMoneyVC.setTabarImage(imageName: "arrow.left.arrow.right", title: "Move Money")
        moreVC.setTabarImage(imageName: "ellipsis.circle", title: "More")
        
        let summaryNC = UINavigationController(rootViewController: summaryVC)
        let moveMoneyNC = UINavigationController(rootViewController: moveMoneyVC)
        let moreNC = UINavigationController(rootViewController: moreVC)
        
        summaryNC.navigationBar.tintColor = Theme.appColor
        hideNavigationBarLine(summaryNC.navigationBar)
        
        let barList = [summaryNC, moveMoneyNC, moreNC]
        viewControllers = barList
    }
    
    private func hideNavigationBarLine(_ navigationBar: UINavigationBar) {
        let img = UIImage()
        navigationBar.shadowImage = img
        navigationBar.setBackgroundImage(img, for: .default)
        navigationBar.isTranslucent = false
    }
    
    func setupTabBar(){
        tabBar.tintColor = Theme.appColor
        tabBar.isTranslucent = false
    }
}





class AccountSummaryViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}


class MoveMoneyViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}


class MoreViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}
