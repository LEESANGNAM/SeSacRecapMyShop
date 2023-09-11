//
//  TabBarController.swift
//  SeSacRecapMyShop
//
//  Created by 이상남 on 2023/09/09.
//

import UIKit

class TabBarController: UITabBarController {
    let movieTrendWeekViewController = UINavigationController(rootViewController: SearchViewcontroller())
    let multipleViewcontroller = UINavigationController(rootViewController: LikeViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [movieTrendWeekViewController,multipleViewcontroller]
        setUpTabbar()
    }
    func setUpTabbar(){
        self.tabBar.tintColor = .label
        self.tabBar.unselectedItemTintColor = .systemGray
        self.tabBar.backgroundColor = .systemBackground
        
        movieTrendWeekViewController.tabBarItem.title = "검색"
        movieTrendWeekViewController.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        multipleViewcontroller.tabBarItem.title = "좋아요목록"
        multipleViewcontroller.tabBarItem.image = UIImage(systemName: "heart")
    }
    
}
