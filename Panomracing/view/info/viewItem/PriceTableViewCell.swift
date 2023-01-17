//
//  PriceTableViewCell.swift
//  Panomracing
//
//  Created by Ssoft_dev on 8/8/22.
//

import UIKit

class PriceTableViewCell: UITableViewCell {
    
    
    static let identifier = "PriceTableViewCell"

    @IBOutlet weak var valueLB: UILabel!
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var bgView: UIView!
    var position:Int = 0
    var barcode:Barcode? {
        
        didSet {
            setValue()
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setHeader(){
        valueLB.textColor = .white
//
        titleLB.text = " "
        valueLB.text = "ราคาขาย"
        
        bgView.backgroundColor = UIColor(named: "primary")
        
    }
    
    func setColor(state:Int){
        valueLB.textColor = .gray
        titleLB.textColor = .gray

        if state == 0 {
            
            bgView.backgroundColor = UIColor(named: "red_soft")

        }else{
            
            bgView.backgroundColor = UIColor(named: "gray_soft")

        }
        
    }
    
    
    
    func setValue(){
        if position == 1 {
            let va = String(format: "%.2f", barcode!.Price1 ?? 0)

            titleLB.text = "ราคาที่ 1 "
            valueLB.text = "\(va)"
            
        }else{
            let va = String(format: "%.2f", barcode!.Price4 ?? 0)

            titleLB.text = "เมื่อซื้อ 6 ชิ้นขึ้นไป "
            valueLB.text = "\(va)"
            
        }
        
        
    }
    
    
    
}
