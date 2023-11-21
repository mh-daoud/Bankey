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
    let mainViewController = MainViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        loginViewController.delegate = self
        onBoardingContainerViewController.delegate = self
        
        displayLogin()
        return true
    }
    
    private func displayLogin(){
        setRootViewController(loginViewController)
    }
    
    private func displayNextScreen() {
        if LocalState.hasOnBoarded {
            prepMainView()
            setRootViewController(mainViewController)
        } else {
            setRootViewController(onBoardingContainerViewController)
        }
    }
    
    private func prepMainView() {
        mainViewController.setStatusBar()
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = Theme.appColor
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
        displayNextScreen()
    }
}

extension AppDelegate : OnBoardingContainerViewControllerDelegate {
    func didFinishOnBoarding() {
        LocalState.hasOnBoarded = true
        prepMainView()
        setRootViewController(mainViewController)
    }
}

extension AppDelegate : LogoutDelegate {
    func didLogout() {
        setRootViewController(loginViewController)
    }
}
