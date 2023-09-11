//
//  TabBarController.swift
//  SeSacRecapMyShop
//
//  Created by 이상남 on 2023/09/09.
//

import UIKit

class TabBarController: UITabBarController {
    let searchViewcontroller = UINavigationController(rootViewController: SearchViewcontroller())
    let likeViewController = UINavigationController(rootViewController: LikeViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [searchViewcontroller,likeViewController]
        setUpTabbar()
    }
    func setUpTabbar(){
        self.tabBar.tintColor = .label
        self.tabBar.unselectedItemTintColor = .systemGray
        self.tabBar.backgroundColor = .systemBackground
        
        searchViewcontroller.tabBarItem.title = "검색"
        searchViewcontroller.tabBarItem.image = UIImage(systemName: ImageName.search)
        likeViewController.tabBarItem.title = "좋아요목록"
        likeViewController.tabBarItem.image = UIImage(systemName: ImageName.Like)
    }
    
}
