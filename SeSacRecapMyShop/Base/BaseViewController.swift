//
//  ViewController.swift
//  SeSacRecapMyShop
//
//  Created by 이상남 on 2023/09/08.
//

import UIKit

class BaseViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setConstraints()
        setDelegate()
        // Do any additional setup after loading the view.
    }
    

    func setUpView(){
        view.backgroundColor = .black
    }
    func setConstraints(){ }
    func setDelegate(){ }

}

