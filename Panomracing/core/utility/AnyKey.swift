//
//  AnyKey.swift
//  Panomracing
//
//  Created by Ssoft_dev on 8/7/22.
//

import Foundation
public struct AnyKey: CodingKey {
    public var stringValue: String
    public var intValue: Int?
    public init(stringValue: String) {
        self.stringValue = stringValue
    }

    public init?(intValue: Int) {
        self.stringValue = String(intValue)
        self.intValue = intValue
    }
}
