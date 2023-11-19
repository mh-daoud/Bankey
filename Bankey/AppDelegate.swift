//
//  AppDelegate.swift
//  Bankey
//
//  Created by admin on 15/11/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window : UIWindow?
    let loginViewController = LoginViewController()
    let onBoardingContainerViewController = OnBoardingContainerViewController()
    let dummyViewController = DummyViewController()
    let mainViewController = MainViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        loginViewController.delegate = self
        onBoardingContainerViewController.delegate = self
        dummyViewController.delegate = self
        //window?.rootViewController = mainViewController //loginViewController
        window?.rootViewController = AccountSummaryViewController()

        return true
    }
}


extension AppDelegate {
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated , let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
}

extension AppDelegate : LoginViewControllerDelegate {
    func didLogin() {
        if LocalState.hasOnBoarded {
            setRootViewController(dummyViewController)
        }
        else {
            setRootViewController(onBoardingContainerViewController)
        }
    }
}

extension AppDelegate : OnBoardingContainerViewControllerDelegate {
    func didFinishOnBoarding() {
        LocalState.hasOnBoarded = true
        setRootViewController(dummyViewController)
    }
}

extension AppDelegate : LogoutDelegate {
    func didLogout() {
        setRootViewController(loginViewController)
    }
}
