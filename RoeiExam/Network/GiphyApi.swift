//
//  GiphyApi.swift
//  RoeiExam
//
//  Created by roei baruch on 06/06/2019.
//  Copyright © 2019 roei baruch. All rights reserved.
//

import Foundation

enum GiphyApi {
    case search(String, String)
    case random
}

extension GiphyApi: EndpointType {
    
    var baseURL: URL {
        return URL(string: "http://api.giphy.com/v1/gifs/")!
    }
    
    var path: String {
        switch self {
        case .search(let text, let offset):
            return "search?q=\(text)&api_key=Zz7XnA0RZzJJetQAQv1e2c7ErivA9F5u&offset=\(offset)"
        case .random:
            return "random?&api_key=Zz7XnA0RZzJJetQAQv1e2c7ErivA9F5u"
        }
        
    }
}
