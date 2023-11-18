//
//  OnBoardingContainerViewController.swift
//  Bankey
//
//  Created by admin on 18/11/2023.
//

import UIKit

protocol OnBoardingContainerViewControllerDelegate: AnyObject {
    func didFinishOnBoarding()
}

class OnBoardingContainerViewController : UIViewController {
    
    let pageViewController: UIPageViewController
    var pages = [UIViewController]()
    var currentVC: UIViewController
    let closeButton = UIButton(type: .system)
    let doneButton = UIButton(type: .system)
    weak var delegate: OnBoardingContainerViewControllerDelegate?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pages.append(OnBoardingViewController(heroImageName: "delorean", titleText: "Bankey is faster, easier to use, and has a brand new look and feel that will make you feel like you are back in the 80s."))
        pages.append(OnBoardingViewController(heroImageName: "world", titleText: "Move your money around the world quickly and securely."))
        pages.append(OnBoardingViewController(heroImageName: "thumbs", titleText: "Learn more at www.bankey.com."))
        currentVC = pages.first!
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setup()
        style()
        layout()
    }
}

extension OnBoardingContainerViewController {
    private func setup(){
        super.viewDidLoad()
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageViewController.dataSource = self
        pageViewController.delegate = self
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        
        pageViewController.setViewControllers([pages.first!], direction: .forward, animated: false)
        currentVC = pages.first!
    }
    
    private func style(){
        view.backgroundColor = .systemPurple
        
        //Close Button
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setTitle("Close", for: [])
        closeButton.addTarget(self, action: #selector(closeTapped), for: .primaryActionTriggered)
        view.addSubview(closeButton)
        
        //Done Button
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.setTitle("Done", for: [])
        doneButton.addTarget(self, action: #selector(doneTapped), for: .primaryActionTriggered)
        doneButton.isHidden = true
        view.addSubview(doneButton)
        
    }
    
    private func layout(){
        //Close Button
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            closeButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2)
        ])
        
        //Page View
        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        //Close Button
        NSLayoutConstraint.activate([
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: doneButton.trailingAnchor, multiplier: 2),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: doneButton.bottomAnchor, multiplier: 4)
        ])
    }
}

extension OnBoardingContainerViewController : UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getPerviousViewController(from: viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getNextViewController(from: viewController)
    }
    
    private func getPerviousViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else {return nil}
        currentVC = pages[index - 1]
        return pages[index - 1]
    }
    
    private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else {return nil}
        currentVC = pages[index + 1]
        return pages[index+1]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        let index = pages.firstIndex(of: currentVC) ?? 0
        return index
    }
}

extension OnBoardingContainerViewController : UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        updateDoneButtonVisibility(pendingViewControllers.first!)
    }
    
    private func updateDoneButtonVisibility(_ vc: UIViewController) {
        guard let index = pages.firstIndex(of: vc) else {
            return
        }
        if index == (pages.count - 1) {
            doneButton.isHidden = false
        }
        else {
            doneButton.isHidden = true
        }
    }
}

// MARK: Actions
extension OnBoardingContainerViewController {
    
    @objc private func closeTapped(){
        delegate?.didFinishOnBoarding()
    }
    
    @objc private func doneTapped(){
        delegate?.didFinishOnBoarding()
    }
}
