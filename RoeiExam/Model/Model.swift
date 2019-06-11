//
//  Model.swift
//  RoeiExam
//
//  Created by roei baruch on 06/06/2019.
//  Copyright © 2019 roei baruch. All rights reserved.
//

import Foundation

struct GifData: Codable {
    var data: [Gif]?
    var pagination: Pagination?
}

struct Pagination: Codable {
    var total_count: Int?
    var count: Int?
    var offset: Int?
}

struct Gif: Codable {
    var url: String?
    var id: String?
    var source: String?
    var images: Images?
}

struct Images: Codable {
    var fixed_height: FixedHeight?
}

struct FixedHeight: Codable {
    var url: String?
}
