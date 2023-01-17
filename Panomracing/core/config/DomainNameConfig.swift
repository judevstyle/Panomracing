//
//  DomainNameConfig.swift
//  Panomracing
//
//  Created by Ssoft_dev on 8/7/22.
//

import Foundation

public enum DomainNameConfig {
    case products
    case info
    case stock
    case baseUrl

    
}

extension DomainNameConfig {

    public var urlString: String {
//        43.229.149.79:8333 http://58.8.78.20:8333/api-doc
        let baseURL: String = "http://212.80.213.21:8333/api/"
        
        switch self {
        case .products:
            return "getProduct"
        case .info:
            return "getProductDetail/"
        case .stock:
            return "getProductStock/"
        case .baseUrl:
            return "\(baseURL)"

        }
    }
    
    public var headerKey: String {
        switch self {
        default:
            return ""
        }
    }
    
    public var url: URL {
        return URL(string: self.urlString)!
    }
}
