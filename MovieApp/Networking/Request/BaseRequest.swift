//
//  BaseRequest.swift
//  MovieApp
//
//  Created by krushankant on 2/19/22.
//  Copyright © 2022 Patel. All rights reserved.
//

import Foundation
import Alamofire

public protocol BaseRequest: URLRequestConvertible {
    
    // The base URL.
    var baseURL: URL { get }
    
    // The path to be appended into baseURL for create the fullURL.
    var path: String { get }
    
    // The HTTP method used in the request.
    var method: HTTPMethod { get }
    
    // The HTTP parameters used in the request.
    var parameters: Parameters { get }
    
    // The HTTP parameters encoding format used in the request
    var encoding: ParameterEncoding { get }
    
    // The headers to be used in the request.
    var headers: [String: String]? { get }
    
}

