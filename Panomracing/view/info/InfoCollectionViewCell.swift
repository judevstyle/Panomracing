//
//  InfoCollectionViewCell.swift
//  Panomracing
//
//  Created by Ssoft_dev on 8/8/22.
//

import UIKit
import Combine

class InfoCollectionViewCell: UICollectionViewCell {

    
    var getHeader: ProductUseCase = ProductUseCaseImpl()
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    static let identifier = "InfoCollectionViewCell"

    @IBOutlet weak var imageIV: UIImageView!
    @IBOutlet weak var code: UILabel!
    @IBOutlet weak var nameT: UILabel!
    @IBOutlet weak var nameE: UILabel!
    
    @IBOutlet weak var subUnit: UILabel!
    @IBOutlet weak var unit: UILabel!
    @IBOutlet weak var perUnit: UILabel!
    @IBOutlet weak var note: UILabel!
    
    @IBOutlet weak var priceTableView: UITableView!
    @IBOutlet weak var barcodeTableView: UITableView!
    
    @IBOutlet weak var priceHigthConstance: NSLayoutConstraint!
    @IBOutlet weak var barcodeHigthConstance: NSLayoutConstraint!
    var positionSelect = 1
    
//    var info:ProductInfo?
    var barcodeText:String = ""
    var barcodeState:Bool = false

    var productID:String? {
        
        didSet {
            getInfo(text: productID!)
        }
        
    }
    
    
    var barcode:Barcode? {
        didSet {
            self.priceTableView.reloadData()
        }
        
    }
    
    var barcodes:[Barcode]?

    
    var info:ProductInfo? {
        
        didSet {
            setView()
        }
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initTableView()
        // Initialization code
    }
    
    
    func initTableView(){
        
//        barcodeIM.image = barcodeIM.image?.withRenderingMode(.alwaysTemplate)
//        barcodeIM.tintColor = UIColor(named: "primary")
        
        
        barcodeTableView.delegate = self
        barcodeTableView.dataSource = self
        barcodeTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        barcodeTableView.estimatedRowHeight = 80
        barcodeTableView.rowHeight = UITableView.automaticDimension
        barcodeTableView.registerCell(identifier: BarcodeTableViewCell.identifier)
        
        barcodeTableView.layoutIfNeeded()
        
        priceHigthConstance.constant = CGFloat(7.0*44)

        barcodeTableView.isScrollEnabled = false

        
//        let numberOfSections = self.barcodeTableView.numberOfSections
//         let numberOfRows = self.barcodeTableView.numberOfRows(inSection: numberOfSections-1)
//
//         let indexPath = IndexPath(row: numberOfRows-1 , section: numberOfSections-1)
//         self.barcodeTableView.scrollToRow(at: indexPath, at: .middle, animated: true)
        self.barcodeTableView.reloadData()
        
        priceTableView.delegate = self
        priceTableView.dataSource = self
        priceTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        priceTableView.estimatedRowHeight = 80
        priceTableView.rowHeight = UITableView.automaticDimension
        priceTableView.registerCell(identifier: PriceTableViewCell.identifier)
        priceTableView.isScrollEnabled = false

        
        
    }
    
    func setView(){
        
        code.text = "รหัสสินค้า : \(info!.mpCode!)"
        nameT.text = "ชื่อสินค้า(TH) : \(info!.tmpName!)"
        nameE.text = "ชื่อสินค้า(EN) : \(info!.empName!)"
        note.text = "\(info!.note ?? "-")"

        
        subUnit.text = "หน่วยย่อย : \(info!.unit?.sub_unit ?? "")"
        unit.text = "หน่วยใหญ่ : \(info!.unit?.unit ?? "")"
        perUnit.text = "อัตราหน่วยย่อย : \(info!.unit?.item_per_unit ?? 0)"

        print("barcode count \(info!.barcode?.count)")
        
        self.barcodes = info!.barcode
        self.barcodeTableView.reloadData()
        barcodeHigthConstance.constant = CGFloat((Float(info!.barcode?.count ?? 0)+1)*38)

        
        if info!.picture != nil {
            let imageData = Data(base64Encoded: info!.picture!, options: .init(rawValue: 0))
            imageIV.image = UIImage(data: imageData!)
        }
        

        
    }
    
    

}



extension InfoCollectionViewCell :  UITableViewDelegate, UITableViewDataSource,OnClickstate {
    func onClickStateChangePosition(position: Int) {
        self.positionSelect = position
        self.barcodeTableView.reloadData()
        self.barcode = self.barcodes![position-1]
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

       
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.barcodeTableView {
            return (self.barcodes?.count ?? 0) + 1
        }else{
            
            if self.barcode != nil {
                return 3
                
            }else{
                    return 0
            }

        }
        
//        return (self.products?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if tableView == self.barcodeTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: BarcodeTableViewCell.identifier, for: indexPath) as! BarcodeTableViewCell
//            cell.product = products![indexPath.row]
            if indexPath.row == 0 {
                cell.setHeader()
            }else{
                cell.onClickstate = self
                cell.position = indexPath.row
                cell.barcode = self.barcodes![indexPath.row-1]
                if indexPath.row == positionSelect{
                    cell.state = true
                }else {
                    cell.state = false

                }
            }
            cell.selectionStyle = .none

            return cell

        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: PriceTableViewCell.identifier, for: indexPath) as! PriceTableViewCell
//            cell.product = products![indexPath.row]
            
            if indexPath.row == 0 {
                cell.setHeader()
            }else{
                cell.setColor(state: indexPath.row%2)
                cell.position = indexPath.row
                cell.barcode = self.barcode
                
                
            }
            
            cell.selectionStyle = .none

            return cell

        }
            

        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//
//        self.viewWillLayoutSubviews()
//    }
//
}


extension InfoCollectionViewCell {

    func getInfo(text:String) {
//        ProgressHUD.show()

    

        self.getHeader.executeInfo(text: text).sink { completion in
            debugPrint("getUserProfileUseCase \(completion)")

        } receiveValue: { resp in
//            debugPrint("resp \(resp)")

            
            
            if let item = resp {
//                self.headerData = resp?.data
//                ProgressHUD.dismiss()

                var respData = resp
                
                var tmp:[Barcode] = []
                if self.barcodeState && resp?.data != nil {
                    
                    for data in resp!.data!.barcode! {
                        
                        if data.BCCode == self.barcodeText {
                            tmp.append(data)// = data
                            break

                        }
                        
                    }
                    
                    respData?.data?.barcode = tmp
                    
                }
                 
                self.info = respData?.data

                if respData?.data?.barcode == nil || (respData?.data?.barcode!.count)! < 1 {

                }else {
                    
                    self.barcode = respData?.data?.barcode![0]

                }
                
//                self.tableView.reloadData()
                print("json \( self.info)")
                
//                let indexPath = IndexPath(item: 0, section: 0)
//                self.tableView.reloadRows(at: [indexPath], with: .none)
//                self.getNews()
            }
        }.store(in: &self.anyCancellable)
    }
}
