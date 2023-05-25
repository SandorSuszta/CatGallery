//
//  ViewController.swift
//  PageViewConrtroller
//
//  Created by Nataliia Shusta on 25/05/2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    private var pages: [UIViewController] = []
    
    //MARK: - UI Elements
    
    private lazy var pageController: UIPageViewController = {
        let controller = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal
        )
        controller.view.backgroundColor = .clear
        controller.dataSource = self
        controller.delegate = self
        return controller
    }()
    
    private var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.backgroundColor = .clear
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPage = 0
        return pageControl
    }()
    
    private lazy var previousButton: MyButton = {
        let button = MyButton(title: "PREVIOUS")
        button.addTarget(self, action: #selector(previousButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextButton: MyButton = {
        let button = MyButton(title: "NEXT")
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var blackAndWhiteButton: MyButton = {
        let button = MyButton(title: "BLACK & WHITE")
        button.addTarget(self, action: #selector(blackAndWhiteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureViewHierarchy()
        configureViewLayout()
        pages = makePages()
        pageController.setViewControllers([pages[0]], direction: .forward, animated: true)
        
    }
    
    //MARK: - Button event handlers
    
    @objc private func blackAndWhiteButtonTapped() {
        
    }
    
    @objc private func previousButtonTapped() {
        
        if let currentVC = pageController.viewControllers?.first,
           let currentIndex = pages.firstIndex(of: currentVC),
           currentIndex > 0 {
            let previousIndex = currentIndex - 1
            pageController.setViewControllers([pages[previousIndex]], direction: .reverse, animated: true)
            pageControl.currentPage = previousIndex
        }
    }
    
    @objc private func nextButtonTapped() {
        
        if let currentVC = pageController.viewControllers?.first,
           let currentIndex = pages.firstIndex(of: currentVC),
           currentIndex < pages.count - 1 {
            let nextIndex = currentIndex + 1
            pageController.setViewControllers([pages[nextIndex]], direction: .forward, animated: true)
            pageControl.currentPage = nextIndex
        }
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
        view.addSubview(pageControl)
        view.addSubview(blackAndWhiteButton)
        view.addSubview(previousButton)
        view.addSubview(nextButton)
    }
    
    private func configureViewLayout() {
        pageController.view.translatesAutoresizingMaskIntoConstraints = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        blackAndWhiteButton.translatesAutoresizingMaskIntoConstraints = false
        previousButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            pageController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 170),
            pageController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageController.view.heightAnchor.constraint(equalToConstant: 400),
            
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.topAnchor.constraint(equalTo: pageController.view.bottomAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 50),
            pageControl.widthAnchor.constraint(equalToConstant: 200),
            
            blackAndWhiteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -75),
            blackAndWhiteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            blackAndWhiteButton.widthAnchor.constraint(equalToConstant: 270),
            blackAndWhiteButton.heightAnchor.constraint(equalToConstant: 50),
            
            previousButton.bottomAnchor.constraint(equalTo: blackAndWhiteButton.topAnchor, constant: -36),
            previousButton.leadingAnchor.constraint(equalTo: blackAndWhiteButton.leadingAnchor),
            previousButton.widthAnchor.constraint(equalToConstant: 120),
            previousButton.heightAnchor.constraint(equalToConstant: 50),
            
            nextButton.bottomAnchor.constraint(equalTo: blackAndWhiteButton.topAnchor, constant: -36),
            nextButton.trailingAnchor.constraint(equalTo: blackAndWhiteButton.trailingAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 120),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

    //MARK: - PageViewController Delegate and DataSource methods

extension MainViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
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
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let currentViewController = pageViewController.viewControllers?.first,
           let currentIndex = pages.firstIndex(of: currentViewController) {
            pageControl.currentPage = currentIndex
        }
    }
}
