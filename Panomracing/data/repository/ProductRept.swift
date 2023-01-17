//
//  ProductRept.swift
//  Panomracing
//
//  Created by Ssoft_dev on 8/7/22.
//

import Foundation
import Combine
import Moya

protocol ProductRept {
    func products( request:String) -> AnyPublisher<ProductResponse, Error>
    func info( request:String) -> AnyPublisher<InfoResponse, Error>
    func stock( request:String) -> AnyPublisher<StockResponse, Error>

}


final class ProductRepositoryImpl: ProductRept {
    
    func stock(request: String) -> AnyPublisher<StockResponse, Error> {
        return self.provider
            .cb
            .request(.getStock(id: request))
            .map(StockResponse.self)
    }
    
    
    func info(request: String) -> AnyPublisher<InfoResponse, Error> {
        return self.provider
            .cb
            .request(.getInfo(id: request))
            .map(InfoResponse.self)
    }
    
    private let provider: MoyaProvider<ProductApi> = MoyaProvider<ProductApi>()

    func products(request:String) -> AnyPublisher<ProductResponse, Error> {
        return self.provider
            .cb
            .request(.getProducts(text: request))
            .map(ProductResponse.self)
    }

    
}
