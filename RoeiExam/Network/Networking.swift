//
//  Networking.swift
//  RoeiExam
//
//  Created by roei baruch on 06/06/2019.
//  Copyright © 2019 roei baruch. All rights reserved.
//

import Foundation
import Alamofire

struct Networking {
    
    func preformNetwokTask<T: Codable>(endPoint: GiphyApi, type: T.Type, complition: ((_ response: T) -> Void)?, failure: @escaping () -> Void) {
        
        guard let url = endPoint.baseURL.appendingPathComponent(endPoint.path).absoluteString.removingPercentEncoding  else { return }
        print("url is: \(url)")
        Alamofire.request(url).responseJSON { (response) in
            if response.result.isFailure {
                failure()
            }
            
            if let data = response.data {
                let response = Response(data: data)
                guard let decode = response.decode(type) else { return }
                complition?(decode)
            }
            
        }
    }
}
