//
//  GifTableViewCellModel.swift
//  RoeiExam
//
//  Created by roei baruch on 07/06/2019.
//  Copyright © 2019 roei baruch. All rights reserved.
//

import Foundation
import UIKit

class GifTableViewCellModel {
    
    private let gif: Gif?
    
    init(gif: Gif) {
        self.gif = gif
    }
    
    var url: String {
        return gif?.images?.fixed_height?.url ?? ""
    }
    
    var source: String {
        return gif?.source ?? ""
    }
    
    func preview() {
        
    }
}
