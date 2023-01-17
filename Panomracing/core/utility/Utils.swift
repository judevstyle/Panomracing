//
//  Utils.swift
//  Panomracing
//
//  Created by Ssoft_dev on 8/7/22.
//

import Foundation
class Utils {
    static func jsonData(from object: Any) -> Data? {
        return try? JSONSerialization.data(withJSONObject: object, options: [])
    }
}
