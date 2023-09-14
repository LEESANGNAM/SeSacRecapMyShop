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
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc private func keyboardDown(){
        view.endEditing(true)
    }
    
    func showAlert(text: String, addButtonText: String? = nil, Action: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "경고!", message: text, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "취소", style: .destructive)
        alert.addAction(cancel)
        
        if let buttonText = addButtonText {
            let customAction = UIAlertAction(title: buttonText, style: .default) { _ in
                Action?()
            }
            alert.addAction(customAction)
        }
        
        present(alert, animated: true)
    }
}

