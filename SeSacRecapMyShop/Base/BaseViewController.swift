//
//  ViewController.swift
//  SeSacRecapMyShop
//
//  Created by 이상남 on 2023/09/08.
//

import UIKit

class BaseViewController: UIViewController, BaseProtocol {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setConstraints()
        setDelegate()
        // Do any additional setup after loading the view.
    }
    

    func setUpView(){
        view.backgroundColor = .systemBackground
    }
    func setConstraints(){ }
    func setDelegate(){ }

}

