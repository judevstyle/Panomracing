//
//  StockResponse.swift
//  Panomracing
//
//  Created by Ssoft_dev on 8/8/22.
//

import Foundation

public struct StockResponse: Codable, Hashable {
    public var success: Bool?
    public var data: ProductStock?
    public var message: String?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try success    <- decoder["success"]
        try data       <- decoder["data"]
        try message          <- decoder["message"]
    }
    
}


public struct ProductStock: Codable, Hashable {
    public var result: [Result]?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try result    <- decoder["result"]
    }
    
}

public struct Result: Codable, Hashable {
    public var BF_Qty: Int?
    public var Bal_Qty: Int?
    public var Bal_UnitPrice: Double?
    public var Bal_Val: Double?
    public var MP_Id: Int?
    public var WH_Id: Int?
    public var wharehouse: Wharehouse?

    public init() {}
    
    public init(from decoder: Decoder) throws {
        try BF_Qty    <- decoder["BF_Qty"]
        try Bal_Qty    <- decoder["Bal_Qty"]
        try Bal_UnitPrice    <- decoder["Bal_UnitPrice"]
        try Bal_Val    <- decoder["Bal_Val"]
        try MP_Id    <- decoder["MP_Id"]
        try WH_Id    <- decoder["WH_Id"]
        try wharehouse    <- decoder["wharehouse"]


    }
    
}


public struct Wharehouse: Codable, Hashable {
    public var BH_Id: Int?
    public var EWHName: String?
    public var Id: Int?
    public var TWHName: String?
    public var WHBuying: Bool?
    public var WHCode: String?
    public var WHSelling: Bool?
    public var branch: Branch?

    public init() {}
    
    public init(from decoder: Decoder) throws {
        try BH_Id    <- decoder["BH_Id"]
        try EWHName    <- decoder["EWHName"]
        try Id    <- decoder["Id"]
        try TWHName    <- decoder["TWHName"]
        try WHBuying    <- decoder["WHBuying"]
        try WHCode    <- decoder["WHCode"]
        try WHSelling    <- decoder["WHSelling"]
        try branch    <- decoder["branch"]

    }
    
}
public struct Branch: Codable, Hashable {
    public var Addr_ZipCode: String?
    public var BHCode: String?
    public var EAddr_Province: String?
    public var EAddr_Row1: String?
    public var EAddr_Row2: String?
    public var EBHName: String?
    public var EFullName: String?
    public var Email: String?
    public var Fax: String?
    public var Id: Int?
    public var Phone: String?
    public var TAddr_Province: String?
    public var TAddr_Row1: String?
    public var TAddr_Row2: String?
    public var TBHName: String?
    public var TFullName: String?
    public var Website: String?

    public init() {}
    
    public init(from decoder: Decoder) throws {
        try Addr_ZipCode    <- decoder["Addr_ZipCode"]
        try BHCode    <- decoder["BHCode"]
        try EAddr_Province    <- decoder["EAddr_Province"]
        try EAddr_Row1    <- decoder["EAddr_Row1"]
        try EAddr_Row2    <- decoder["EAddr_Row2"]
        try EBHName    <- decoder["EBHName"]
        try EFullName    <- decoder["EFullName"]
        try Email    <- decoder["Email"]
        try Fax    <- decoder["Fax"]
        try Id    <- decoder["Id"]
        try Phone    <- decoder["Phone"]
        try TAddr_Province    <- decoder["TAddr_Province"]
        try TAddr_Row1    <- decoder["TAddr_Row1"]
        try TAddr_Row2    <- decoder["TAddr_Row2"]
        try TBHName    <- decoder["TBHName"]
        try TFullName    <- decoder["TFullName"]
        try Website    <- decoder["Website"]

    }
    
}
