//
//  NetworkManager.swift
//  MovieApp
//
//  Created by krushankant on 2/19/22.
//  Copyright © 2022 Patel. All rights reserved.
//

import Foundation
import Alamofire

public enum NetworkError: Error {
    case unknown
    case connection(Error)
    case corruptedData
}

typealias Completion<T: Codable> = (_ responseObject: Response<T>) -> Void
typealias NetworkManagerRequest = DataRequest

class NetworkManager {
    static var shared = NetworkManager()
    private let manager = Session.default
    
    private init() {}
    
    @discardableResult func perform<T : Codable>(_ request: MovieRequest, handleCompletion: @escaping (Response<T>) -> Void) -> NetworkManagerRequest? {
        let dataRequest = manager.request(request)
        dataRequest.responseData { (dataResponse) in
            let result: Result<T, NetworkError>
            let statusCode = dataResponse.response?.statusCode ?? 0
            if statusCode == 0 {
                result = .failure(NetworkError.unknown)
            } else {
                switch dataResponse.result {
                case .success(let value):
                    if let object = T(jsonData: value) {
                        result = .success(object)
                    } else {
                        result = .failure(NetworkError.corruptedData)
                    }
                case .failure(let error):
                    result = .failure(NetworkError.connection(error))
                }
            }
            handleCompletion(Response<T>(request: dataRequest.request,
                                         response: dataResponse.response,
                                         data: dataResponse.data, result: result))
        }
        return dataRequest
    }
}
