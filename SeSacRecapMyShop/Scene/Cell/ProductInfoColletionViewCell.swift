//
//  ProductInfoColletionViewCell.swift
//  SeSacRecapMyShop
//
//  Created by 이상남 on 2023/09/09.
//

import UIKit
import Kingfisher

class ProductInfoColletionViewCell: BaseCollectionViewCell {
    let posterImageView = {
        let image = UIImageView()
        image.backgroundColor = .systemYellow
        image.layer.cornerRadius = 5
        return image
    }()
    let mallNameLabel = {
        let label = UILabel()
        label.text = "제품 업체명"
        return label
    }()
    let titleNameLabel = {
        let label = UILabel()
        label.text = "제품명(소개)"
        label.numberOfLines = 2
        return label
    }()
    let infoPriceLabel = {
        let label = UILabel()
        label.text = "가격1,111,111,111"
        return label
    }()
    let likeButton = {
        let button = UIButton()
        let buttonSize:CGFloat = 40
        button.frame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.layer.cornerRadius = buttonSize / 2
        button.backgroundColor = .green
        return button
    }()
    lazy var stackView = {
       let view = UIStackView(arrangedSubviews: [mallNameLabel,titleNameLabel,infoPriceLabel])
        view.axis = .vertical
        view.spacing = 1
        view.alignment = .leading
        view.distribution = .fillProportionally
        return view
    }()
    
    override func setUpView() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(likeButton)
        contentView.addSubview(stackView)
    }
    override func setConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview()
            make.height.equalTo(posterImageView.snp.width)
        }
        likeButton.snp.makeConstraints { make in
            make.trailing.equalTo(posterImageView.snp.trailing).offset(-5)
            make.bottom.equalTo(posterImageView.snp.bottom).offset(-5)
            make.size.equalTo(40)
        }
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(posterImageView.snp.bottom).offset(5)
            make.bottom.lessThanOrEqualToSuperview()
        }
    }
    func setUpCellUI(item: Item){
        if let imageURL = item.imageURL{
            posterImageView.kf.setImage(with: imageURL)
        }else{
            posterImageView.image = UIImage(systemName: "bag.fill.badge.questionmark")
        }
        mallNameLabel.text = item.mallName
        titleNameLabel.text = item.title
        infoPriceLabel.text = item.lprice
    }
    
}
