//
//  Images.swift
//  StoryApp
//
//  Created by 심소영 on 6/12/24.
//

import Foundation

struct Images: Decodable {
    let documents: [Document]
    let meta: Meta
}

struct Meta: Decodable {
    let is_end: Bool
    let pageable_count, total_count: Int
}

struct Document: Decodable {
    let thumbnail_url: String
}
