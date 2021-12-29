//
//  ViewController.swift
//  poc-segment-widget
//
//  Created by Norman on 12/28/21.
//

import UIKit

class ViewController: UIPageViewController {
    
    var pages = [UIViewController]()
    let pageControl = UIPageControl()
    let initialPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setUpPageControl()
        setUpLayout()
    }
    
    func setUp() {
        dataSource = self
        delegate = self
        let viewController1 = UIViewController()
        viewController1.view.backgroundColor = .systemTeal
        let viewController2 = UIViewController()
        viewController2.view.backgroundColor = .systemGray
        let viewController3 = UIViewController()
        viewController3.view.backgroundColor = .systemCyan
        
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
        
        pages = [viewController1, viewController2, viewController3]
        setViewControllers([pages[initialPage]], direction: .forward, animated: false, completion: nil)
    }
    
    func setUpPageControl() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .systemGray2
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
    }
    
    func setUpLayout() {
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: pageControl.bottomAnchor, multiplier: 1),
        ])
    }
}

extension ViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex == 0 {
            return pages.last
        } else {
            return pages[currentIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }

        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]
        } else {
            return pages.first
        }
    }
    
    @objc func pageControlTapped(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: false, completion: nil)
    }
}

extension ViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        
        pageControl.currentPage = currentIndex
    }
}
