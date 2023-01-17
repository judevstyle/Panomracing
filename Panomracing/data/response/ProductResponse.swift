//
//  ProductResponse.swift
//  Panomracing
//
//  Created by Ssoft_dev on 8/7/22.
//

import Foundation

// MARK: - NewsResponse
public struct ProductResponse: Codable, Hashable {
    public var success: Bool?
    public var data: [ProductItem]?
    public var message: String?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try success    <- decoder["success"]
        try data       <- decoder["data"]
        try message          <- decoder["message"]
    }
    
}

// MARK: - DataClass
public struct ProductItem: Codable , Hashable{
    public var Id:Int?
    public var mpCode:String?
    public var tmpName: String?
    public var empName: String?
    public var mainBarcode:String?
    public var price:Double?
    public var barCodeAll:String?

    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try Id    <- decoder["Id"]
        try mpCode    <- decoder["MPCode"]
        try tmpName    <- decoder["TMPName"]
        try empName       <- decoder["EMPName"]
        try mainBarcode          <- decoder["MainBarcode"]
        try price          <- decoder["Price"]
        try barCodeAll          <- decoder["BarCodeAll"]

    }
    
    
    
}
