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
        keyboardDownViewTapped()
        // Do any additional setup after loading the view.
    }
    

    func setUpView(){
        view.backgroundColor = .systemBackground
    }
    func setConstraints(){ }
    func setDelegate(){ }
    
    private func keyboardDownViewTapped(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(keyboardDown))
        view.addGestureRecognizer(tap)
    }
    @objc private func keyboardDown(){
        view.endEditing(true)
    }
}

