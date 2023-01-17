//
//  BarcodeTableViewCell.swift
//  Panomracing
//
//  Created by Ssoft_dev on 8/8/22.
//

import UIKit


protocol OnClickstate{
    
   func onClickStateChangePosition(position:Int)
    
}

class BarcodeTableViewCell: UITableViewCell {
    
    
    static let identifier = "BarcodeTableViewCell"

    @IBOutlet weak var perUnitLB: UILabel!
    @IBOutlet weak var unit: UILabel!
    @IBOutlet weak var nameTV: UILabel!
    @IBOutlet weak var stateBT: UIButton!
    var onClickstate:OnClickstate?
    var position:Int?

    
    var barcode:Barcode? {
        
        didSet {
            setValue()
        }
        
    }
    
    
    var state:Bool = false {
        
        didSet {
            setSelectButton()
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func initView(){
        
        stateBT.setImage(UIImage(named:"radio-false"), for: .normal)
        stateBT.setImage(UIImage(named:"radio-true"), for: .selected)
//        ck.isSelected = true
        stateBT.setTitle("", for: .normal)
        
    }
    
    func setValue(){
        
        
        
        stateBT.isHidden = false
        nameTV.text = "\(barcode!.BCCode ?? "")"
        unit.text = " \(barcode!.unit ?? "")"
        perUnitLB.text = " 1x\(barcode!.UMRatio ?? 0) \(barcode!.unit ?? "")"

        
    }
    
    
    func setSelectButton(){
        
        

        stateBT.isSelected = state
  
        
    }
    
    
    
    
    
    func setHeader(){
        
        stateBT.isHidden = true
        nameTV.text = "บาร์โค้ด"
        unit.text = "หน่วยนับ"
        perUnitLB.text = "อัตรา/หน่วย"

    }
    
    @IBAction func onTapped(_ sender: Any) {
        
        onClickstate?.onClickStateChangePosition(position: self.position!)
        print("lfpe on onTapped")
        
    }
    
    
}
