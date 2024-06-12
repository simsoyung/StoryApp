//
//  SearchBar.swift
//  StoryApp
//
//  Created by 심소영 on 6/12/24.
//

import UIKit

class SearchTextField: UISearchBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
        placeholder = "검색어를 입력하세요"
        tintColor = .black
        layer.borderColor = UIColor.lightGray.cgColor
        backgroundColor = .white
        keyboardType = .default
        layer.cornerRadius = 10
        layer.borderWidth = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
