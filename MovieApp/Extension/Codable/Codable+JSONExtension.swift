//
//  Codable+JSONExtension.swift
//  MovieApp
//
//  Created by krushankant on 2/19/22.
//  Copyright © 2022 Patel. All rights reserved.
//

import Foundation

public extension Decodable where Self: Codable {
    static var decoder: JSONDecoder { return JSONDecoder() }

    // Create instances of our type from JSON Data.
    init?(jsonData: Data?) {
        guard let data = jsonData,
            let anInstance = try? Self.decoder.decode(Self.self, from: data)
            else { return nil }
        self = anInstance
    }
}

extension Encodable where Self: Codable {
    static var encoder: JSONEncoder { return JSONEncoder() }

    // Return instances as JSON Data.
    func jsonData() -> Data? {
        return try? Self.encoder.encode(self)
    }
}
