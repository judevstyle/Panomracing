//
//  DecodableExt.swift
//  Panomracing
//
//  Created by Ssoft_dev on 8/7/22.
//

import Foundation

public extension String {
    func decode<T: Decodable>(type: T.Type) -> T? {
        if let jsonData = self.data(using: .utf8) {
            let decoder = JSONDecoder()
            do {
            let decodable = try decoder.decode(type.self, from: jsonData)
                return decodable
            } catch {
                return nil
            }
        } else {
            return nil
        }
    }
}
