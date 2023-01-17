//
//  ProductApi.swift
//  Panomracing
//
//  Created by Ssoft_dev on 8/7/22.
//

import Foundation
import Moya
import UIKit

public enum ProductApi {
    case getProducts(text: String)
    case getInfo(id: String)
    case getStock(id: String)

}


extension ProductApi: TargetType {
   
    
    public var baseURL: URL {
        return DomainNameConfig.baseUrl.url
//        switch self {
//        case .getProducts:
//            return DomainNameConfig
//
//        case .getInfo:
//            return DomainNameConfig.url
//
//    case .getStock:
//        return DomainNameConfig.url
//    }
        
    
    }
    
    public var path: String {
      switch self {
      case .getProducts(let text):
          return "\(DomainNameConfig.products.urlString)"
        
        case .getInfo(let text):
          return "\(DomainNameConfig.info.urlString)\(text)"

        
      case .getStock(let text):
          return "\(DomainNameConfig.stock.urlString)\(text)"
    }
        
    }
    
    public var method: Moya.Method {
        switch self {
            
        default:
            return .get
        }
    }
    

    public var task: Task {
        switch self {
            case let .getProducts(text):
                return .requestParameters(
                    parameters: [ "text": text], encoding: URLEncoding.queryString)
            default:
                return .requestPlain
            }


    }

   
    public var headers: [String : String]? {
        return ["Content-Type":"application/x-www-form-urlencoded; charset=UTF-8"]
    }
}
