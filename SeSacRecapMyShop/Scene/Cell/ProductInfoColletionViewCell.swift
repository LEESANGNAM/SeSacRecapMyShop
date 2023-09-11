//
//  ProductInfoColletionViewCell.swift
//  SeSacRecapMyShop
//
//  Created by 이상남 on 2023/09/09.
//

import UIKit
import Kingfisher

class ProductInfoColletionViewCell: BaseCollectionViewCell {
    let repository = LikeRepository()
    let posterImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.layer.masksToBounds = true
        return image
    }()
    let mallNameLabel = {
        let label = UILabel()
        label.text = "제품 업체명"
        label.setUpMallLabelStyle()
        return label
    }()
    let titleNameLabel = {
        let label = UILabel()
        label.text = "제품명(소개)"
        label.numberOfLines = 2
        label.setUpTitleLabelStyle()
        return label
    }()
    let infoPriceLabel = {
        let label = UILabel()
        label.text = "가격1,111,111,111"
        label.setUpPriceLabelStyle()
        return label
    }()
    let likeButton = {
        let button = UIButton()
        let buttonSize:CGFloat = 40
        button.frame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        button.tintColor = .black
        button.layer.cornerRadius = buttonSize / 2
        button.backgroundColor = .white
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
        let likeProduct = repository.fetchFilter(item: item)
        if likeProduct.isEmpty {
            likeButton.setImage(UIImage(systemName: ImageName.noLike), for: .normal)
        }else {
            likeButton.setImage(UIImage(systemName: ImageName.Like), for: .normal)
        }
        if let imageURL = item.imageURL{
            posterImageView.kf.setImage(with: imageURL)
        }else{
            posterImageView.image = UIImage(systemName: ImageName.noPosterImage)
        }
        mallNameLabel.text = "[\(item.mallName)]"
        titleNameLabel.text = item.title.removeHTMLTag()
        infoPriceLabel.text = item.lprice.changeFormatPrice()
    }
    func setUpCellUI(likeProduct: LikeProduct){
        likeButton.setImage(UIImage(systemName: ImageName.Like), for: .normal)
        if let imageURL = likeProduct.imageURL{
            posterImageView.kf.setImage(with: imageURL)
        }else{
            posterImageView.image = UIImage(systemName: ImageName.noPosterImage)
        }
        mallNameLabel.text = "[\(likeProduct.mallName)]"
        titleNameLabel.text = likeProduct.title
        infoPriceLabel.text = likeProduct.lprice.changeFormatPrice()
    }
}
