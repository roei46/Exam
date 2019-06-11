//
//  Response.swift
//  RoeiExam
//
//  Created by roei baruch on 06/06/2019.
//  Copyright © 2019 roei baruch. All rights reserved.
//

import Foundation

struct Response {
    fileprivate var data: Data
    init(data: Data) {
        self.data = data
    }
}

extension Response {
    public func decode<T: Codable>(_ type: T.Type) -> T? {
        let jsonDecoader = JSONDecoder()
        do {
            let response = try jsonDecoader.decode(T.self, from: data)
            return response
        } catch _ {
            return nil
        }
    }
}
