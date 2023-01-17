//
//  DecoderExt.swift
//  Panomracing
//
//  Created by Ssoft_dev on 8/7/22.
//

import Foundation
extension Decoder {
    public subscript(_ key: String) -> (Decoder, String) {
        return (self, key)
    }
}
