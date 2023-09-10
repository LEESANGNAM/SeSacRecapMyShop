//
//  DeatilViewController.swift
//  SeSacRecapMyShop
//
//  Created by 이상남 on 2023/09/11.
//

import Foundation
import WebKit

class DetailViewController: BaseViewController, WKUIDelegate{
    var webView: WKWebView!
    var product: Any?
    let repository = LikeRepository()
    var image: UIImage?
    let baseURL = "https://msearch.shopping.naver.com/product/"
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func setUpView() {
        if let product = product as? Item {
            setUIData(item: product)
            configureNavigationBarButton(image: image, selector: #selector(likeButtonTapped))
            loadWebView(with: product.productID)
        }
        if let likeProduct = product as? LikeProduct {
            SetUIData(product: likeProduct)
            configureNavigationBarButton(image: image, selector: #selector(likeButtonTapped))
            loadWebView(with: likeProduct.productID)
        }
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBackground
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
    @objc func likeButtonTapped() {
        if let item = product as? Item {
            if let filterLikeProduct = repository.fetchFilter(item: item).first{
                repository.removeItem(filterLikeProduct)
                image = UIImage(systemName: "heart")
                print("삭제완료")
            } else {
                let likeprodut = LikeProduct(item: item)
                repository.createItem(likeprodut)
                image = UIImage(systemName: "heart.fill")
                print("추가완료")
            }
        }
        if let likeProduct = product as? LikeProduct {
            repository.removeItem(likeProduct)
            image = UIImage(systemName: "heart")
            print("삭제완료")
        }
        updateHeartIcon()
    }
    func loadWebView(with productID: String) {
            let myURL = URL(string: baseURL + productID)
            print(myURL)
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
        }
    func setUIData(item : Item){
        title = item.title.removeHTMLTag()
        let likeProduct = repository.fetchFilter(item: item)
        if likeProduct.isEmpty {
            image = UIImage(systemName: "heart")
        }else {
            image = UIImage(systemName: "heart.fill")
        }
        updateHeartIcon()
    }
    func SetUIData(product: LikeProduct){
        title = product.title
        image = UIImage(systemName: "heart.fill")
        updateHeartIcon()
    }
    func configureNavigationBarButton(image: UIImage?, selector: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: selector)
        navigationItem.rightBarButtonItem?.tintColor = .label
    }
    func updateHeartIcon() {
        navigationItem.rightBarButtonItem?.image = image
    }
}
