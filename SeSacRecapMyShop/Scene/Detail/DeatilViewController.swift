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
    var product: Item?
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let product {
            setUIData(item: product)
        }
    }
    
    override func setUpView() {
        guard let product = product else { return }
        setUIData(item: product)
        configureNavigationBarButton(image: image, selector: #selector(likeButtonTapped))
        loadWebView(with: product.productID)
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBackground
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
    @objc func likeButtonTapped() {
        guard let product = product else { return }
            if let filterLikeProduct = repository.fetchFilter(item: product).first{
                repository.removeItem(filterLikeProduct)
//                image = UIImage(systemName: ImageName.noLike)
                print("삭제완료")
            } else {
                let likeprodut = LikeProduct(item: product)
                repository.createItem(likeprodut)
//                image = UIImage(systemName: ImageName.Like)
                print("추가완료")
            }
        setHeartIcon(item: product)
        updateHeartIcon()
    }
    func loadWebView(with productID: String) {
        guard let myURL = URL(string: baseURL + productID) else { return }
            let myRequest = URLRequest(url: myURL)
            webView.load(myRequest)
        }
    
    func setUIData(item : Item){
        title = item.removeHTMLTagTitle
        setHeartIcon(item: item)
        updateHeartIcon()
    }
    
    func configureNavigationBarButton(image: UIImage?, selector: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: selector)
        navigationItem.rightBarButtonItem?.tintColor = .label
    }
    func setHeartIcon(item : Item){
        if let likeProduct = repository.fetchFilter(item: item).first{
            image = UIImage(systemName: ImageName.Like)
        } else {
            image = UIImage(systemName: ImageName.noLike)
        }
    }
    func updateHeartIcon() {
        navigationItem.rightBarButtonItem?.image = image
    }
}
