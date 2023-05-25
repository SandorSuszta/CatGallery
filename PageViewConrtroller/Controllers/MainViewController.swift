//
//  ViewController.swift
//  PageViewConrtroller
//
//  Created by Nataliia Shusta on 25/05/2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    private var pages: [UIViewController] = []
    
    private lazy var pageController: UIPageViewController = {
        
        let controller = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal
        )
        controller.view.backgroundColor = .clear
        controller.dataSource = self

        return controller
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
    
    @objc private func blackAndWhiteButtonTapped() {
        
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
        view.addSubview(blackAndWhiteButton)
    }
    
    private func configureViewLayout() {
        pageController.view.translatesAutoresizingMaskIntoConstraints = false
        blackAndWhiteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pageController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 170),
            pageController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageController.view.heightAnchor.constraint(equalToConstant: 400),
            
            blackAndWhiteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -75),
            blackAndWhiteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            blackAndWhiteButton.widthAnchor.constraint(equalToConstant: 270),
            blackAndWhiteButton.heightAnchor.constraint(equalToConstant: 50)
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
}
