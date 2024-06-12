//
//  StoryCollectionViewCell.swift
//  StoryApp
//
//  Created by 심소영 on 6/12/24.
//

import UIKit

class StoryCollectionViewCell: UICollectionViewCell {
    
    static let id = "StoryCollectionViewCell"
    let image = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(image)
        image.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
