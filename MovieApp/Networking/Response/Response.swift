//
//  Response.swift
//  MovieApp
//
//  Created by krushankant on 2/19/22.
//  Copyright © 2022 Patel. All rights reserved.
//

import Foundation
import Alamofire

struct Response<Value: Codable> {
    
    var request: URLRequest?
    var response: HTTPURLResponse?
    var data: Data?
    var result: Result<Value, NetworkError>
    
}
