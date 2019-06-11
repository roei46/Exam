//
//  EndpointType.swift
//  RoeiExam
//
//  Created by roei baruch on 06/06/2019.
//  Copyright © 2019 roei baruch. All rights reserved.
//

import Foundation

protocol EndpointType {
    
    var baseURL: URL { get }
    
    var path: String { get }
    
}
