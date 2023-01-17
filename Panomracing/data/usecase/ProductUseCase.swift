//
//  ProductUseCase.swift
//  Panomracing
//
//  Created by Ssoft_dev on 8/7/22.
//

import Foundation

import Moya
import UIKit

import Combine

protocol ProductUseCase {
    func executeProducts(text: String) -> AnyPublisher<ProductResponse?, Error>
    func executeInfo(text: String) -> AnyPublisher<InfoResponse?, Error>
    func executeStock(text: String) -> AnyPublisher<StockResponse?, Error>

}

struct ProductUseCaseImpl: ProductUseCase {
    func executeInfo(text: String) -> AnyPublisher<InfoResponse?, Error> {
        return self.repository
            .info(request: text)
            .map { $0 }
            .eraseToAnyPublisher()
    }
    
    func executeStock(text: String) -> AnyPublisher<StockResponse?, Error> {
        return self.repository
            .stock(request: text)
            .map { $0 }
            .eraseToAnyPublisher()
    }
    


    private let repository: ProductRept

    init(repository: ProductRept = ProductRepositoryImpl()) {
        self.repository = repository
    }

    func executeProducts(text: String) -> AnyPublisher<ProductResponse?, Error> {
        return self.repository
            .products(request: text)
            .map { $0 }
            .eraseToAnyPublisher()
    }


//    func executeNews(request: HeaderRequests) -> AnyPublisher<NewsResponse?, Error> {
//        return self.repository
//            .findNews(request: request)
//            .map { $0 }
//            .eraseToAnyPublisher()
//    }


}
