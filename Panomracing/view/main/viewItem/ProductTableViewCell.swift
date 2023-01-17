//
//  ProductTableViewCell.swift
//  Panomracing
//
//  Created by Ssoft_dev on 8/8/22.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var priceLB: UILabel!
    @IBOutlet weak var codeLB: UILabel!
    @IBOutlet weak var nameLB: UILabel!
    @IBOutlet weak var mainBarcodeLB: UILabel!
    @IBOutlet weak var allBarcodeLB: UILabel!
    static let identifier = "ProductTableViewCell"

    var product:ProductItem? {
        
        didSet {
            setValue()
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bgView.setShadowBoxView()
        bgView.setRounded(rounded: 8)
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setValue(){
        codeLB.text = "รหัส :  \(product!.mpCode!)"
        priceLB.text = "ราคาขาย : \(product!.price!)"
        nameLB.text = "\(product!.tmpName!)"
        mainBarcodeLB.text = "บาร์โค้ดหลัก :  \(product!.mainBarcode!)"
        allBarcodeLB.text = "บาร์โค้ด(All) :  \(product!.barCodeAll!)"
        
    }
    
    
    
}
