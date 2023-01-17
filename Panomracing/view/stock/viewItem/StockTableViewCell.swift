//
//  StockTableViewCell.swift
//  Panomracing
//
//  Created by Ssoft_dev on 8/21/22.
//

import UIKit

class StockTableViewCell: UITableViewCell {

    
    static let identifier = "StockTableViewCell"

    @IBOutlet weak var whLB: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var qtyLB: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initView()
    }
    
    var result:Result? {
        
        didSet{
            setValue()
            
        }
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initView()  {
        bgView.setShadowBoxView()
        bgView.setRounded(rounded: 8)
        
        
    }
    
    
    func setValue(){
        
        whLB.text = "คลังสินค้า : \(result?.wharehouse?.branch?.TBHName ?? "") (\(result?.wharehouse?.TWHName ?? ""))"
        qtyLB.text = "ยอดคงเหลือ : \(result?.Bal_Qty ?? 0) "

    }
    
    
    
}
