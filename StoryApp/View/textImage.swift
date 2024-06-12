//
//  textImage.swift
//  StoryApp
//
//  Created by 심소영 on 6/12/24.
//

import UIKit

class TextImage: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        image = UIImage(named: "sesac")
        contentMode = .scaleAspectFill
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
