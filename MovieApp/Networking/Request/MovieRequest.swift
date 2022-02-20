//
//  MovieRequest.swift
//  MovieApp
//
//  Created by krushankant on 2/19/22.
//  Copyright © 2022 Patel. All rights reserved.
//

import Foundation
import Alamofire

protocol MovieRequest: BaseRequest {}

extension MovieRequest {
    // Default implementations have to be in protocol extention.
    var baseURL: URL                { return URL(string: Domain.baseUrl())! }
    var method: HTTPMethod          { return .get }
    var parameters: [String: Any]   { return [:] }
    var headers: [String: String]?  { return nil }
    var encoding: ParameterEncoding { return URLEncoding.default }
    
    // Creating request for the properties.
    public func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            fatalError("API URL cannot be resolved! Check API URL and/or path for this request.")
        }
        
        // Create a api query Item
        let apiKeyItem = URLQueryItem(name: "api_key", value: APIEndpoint.APIKey)
        
        // Add APIKey to query Items
        var queryItems = components.queryItems ?? []
        queryItems.append(apiKeyItem)
        components.queryItems = queryItems
        
        // Check the components for url
        guard let queriedURL = components.url else {
            fatalError("URL cannot be constructed from URL components!")
        }
        
        do {
            var request = URLRequest(url: queriedURL)
            request.httpMethod = method.rawValue
            request.allHTTPHeaderFields = headers
            return try encoding.encode(request, with: parameters)
        } catch {
            throw error
        }
    }
}

