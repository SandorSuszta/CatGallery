//
//  ViewController.swift
//  PageViewConrtroller
//
//  Created by Nataliia Shusta on 25/05/2023.
//

import UIKit

class ViewController: UIViewController {
    
    private var pages: [UIViewController] = []
    
    private lazy var pageController: UIPageViewController = {
        
        let controller = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal
        )
        
        controller.view.backgroundColor = .green
        controller.delegate = self
        controller.dataSource = self

        return controller
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        configureViewHierarchy()
        configureViewLayout()
        pages = makePages()
        pageController.setViewControllers([pages[0]], direction: .forward, animated: true)
        
    }
    
    //MARK: - Private  methods
    
    private func makePages() -> [UIViewController] {
        
        var pages: [UIViewController] = []
        let imageNames = [ImageNames.cat, ImageNames.dog, ImageNames.hamster]
        
        imageNames.forEach {
            let vc = ImageVC(imageName: $0)
            pages.append(vc)
        }
        
        return pages
    }
    
    //MARK: - View Layout
    
    private func configureViewHierarchy() {
        view.addSubview(pageController.view)
    }
    
    private func configureViewLayout() {
        pageController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pageController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pageController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageController.view.heightAnchor.constraint(equalToConstant: 400),
        ])
    }
}

    //MARK: - PageViewController Delegate and DataSource methods

extension ViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = currentIndex - 1
        
        if previousIndex >= 0 && previousIndex < pages.count {
            return pages[previousIndex]
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = currentIndex + 1
        
        if nextIndex >= 0 && nextIndex < pages.count {
            return pages[nextIndex]
        }
        
        return nil
    }
}


