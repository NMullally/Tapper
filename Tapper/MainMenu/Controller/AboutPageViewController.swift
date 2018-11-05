//
//  AboutPageViewController.swift
//  Tapper
//
//  Created by Niall Mullally on 05/11/2018.
//  Copyright © 2018 Niall Mullally. All rights reserved.
//

import UIKit

class AboutPageViewController: UIPageViewController {

    // Bit pointless but just using it as a way to keep tabs on the pages / able to order them without changing the code elsewhere
    enum Pages: CustomStringConvertible
    {
        case First
        case Second
        case Third
        
        var description: String
        {
            switch self
            {
                case .First: return "AboutPage0"
                case .Second: return "AboutPage1"
                case .Third: return ""
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self

        if let firstPage = orderedViewController.first
        {
            setViewControllers([firstPage],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        
        // Do any additional setup after loading the view.
    }
    
    private func newPageViewController(name: String) -> UIViewController
    {
        return UIStoryboard(name: "MainMenu", bundle: nil).instantiateViewController(withIdentifier:name)
    }
    
    private(set) lazy var orderedViewController: [UIViewController] =
    {
        [self.newPageViewController(name: Pages.First.description),
         self.newPageViewController(name: Pages.Second.description)
         ]
    }()
}

extension AboutPageViewController : UIPageViewControllerDataSource
{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let pageIndex = orderedViewController.firstIndex(of: viewController)
            else
        {
            return nil
        }
        
        let nextIndex = pageIndex - 1
        let vcSize = orderedViewController.count
        
        if (nextIndex < 0 || vcSize < nextIndex)
        {
            return nil
        }
        
        return orderedViewController[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let pageIndex = orderedViewController.firstIndex(of: viewController)
            else
        {
            return nil
        }
        
        let nextIndex = pageIndex + 1
        let vcSize = orderedViewController.count
        
        if (vcSize == nextIndex || vcSize < nextIndex)
        {
            return nil
        }
        
        return orderedViewController[nextIndex]
    }
    
    
}
