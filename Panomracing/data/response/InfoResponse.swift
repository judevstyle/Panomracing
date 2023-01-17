//
//  InfoResponse.swift
//  Panomracing
//
//  Created by Ssoft_dev on 8/8/22.
//

import Foundation
// MARK: - NewsResponse
public struct InfoResponse: Codable, Hashable {
    public var success: Bool?
    public var data: ProductInfo?
    public var message: String?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try success    <- decoder["success"]
        try data       <- decoder["data"]
        try message          <- decoder["message"]
    }
    
}

// MARK: - DataClass
public struct ProductInfo: Codable , Hashable{
    public var Id:Int?
    public var mpCode:String?
    public var tmpName: String?
    public var empName: String?
    public var note:String?
    public var picture:String?
    public var barcode:[Barcode]?
    public var unit:Unit?

    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try Id    <- decoder["Id"]
        try mpCode    <- decoder["MPCode"]
        try tmpName    <- decoder["TMPName"]
        try empName       <- decoder["EMPName"]
        try note          <- decoder["Note"]
        try picture          <- decoder["picture"]
        try barcode          <- decoder["barcode"]
        try unit          <- decoder["unit"]

    }
    
    
    
}
// MARK: - Barcode
public struct Barcode: Codable , Hashable{
    public var state:Bool = false
    public var Id:Int?
    public var MP_Id:String?
    public var BCCode: String?
    public var Buying: Bool?
    public var DPrice:Bool?
    public var MUCode:String?
    public var Price1:Double?
    public var Price2:Double?
    public var Price3:Double?
    public var Price4:Double?
    public var Price5:Double?
    public var Price6:Double?
    public var Price7:Double?
    public var Price8:Double?
    public var Price9:Double?
    public var Price10:Double?
    public var PriceOnSale:Bool?
    public var Selling:Bool?
    public var ServiceChargable:Bool?
    public var UMRatio:Int?
    public var UM_Id:Int?
    public var unit:String?

    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try Id    <- decoder["Id"]
        try MP_Id    <- decoder["MP_Id"]
        try BCCode    <- decoder["BCCode"]
        try Buying       <- decoder["Buying"]
        try DPrice          <- decoder["DPrice"]
        try MUCode          <- decoder["MUCode"]
        try Price1          <- decoder["Price1"]
        try Price2          <- decoder["Price2"]
        try Price3          <- decoder["Price3"]
        try Price4          <- decoder["Price4"]
        try Price5          <- decoder["Price5"]
        try Price6          <- decoder["Price6"]
        try Price7          <- decoder["Price7"]
        try Price8          <- decoder["Price8"]
        try Price9          <- decoder["Price9"]
        try Price10          <- decoder["Price10"]
        try PriceOnSale          <- decoder["PriceOnSale"]
        try Selling          <- decoder["Selling"]
        try ServiceChargable          <- decoder["ServiceChargable"]
        try UMRatio          <- decoder["UMRatio"]
        try UM_Id          <- decoder["UM_Id"]
        try unit          <- decoder["unit"]

        
        
    }
    
    
    
}



// MARK: - Barcode
public struct Unit: Codable , Hashable{
    public var item_per_unit:Int?
    public var sub_unit:String?
    public var unit: String?

    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try item_per_unit    <- decoder["item_per_unit"]
        try sub_unit    <- decoder["sub_unit"]
        try unit    <- decoder["unit"]

    }
    
    
    
}
