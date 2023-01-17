//
//  StockCollectionViewCell.swift
//  Panomracing
//
//  Created by Ssoft_dev on 8/8/22.
//

import UIKit
import Combine

class StockCollectionViewCell: UICollectionViewCell {
    static let identifier = "StockCollectionViewCell"
    var getHeader: ProductUseCase = ProductUseCaseImpl()

    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()

    @IBOutlet weak var tableView: UITableView!
    var stocks:[Result]?
    var productID:String? {
        
        didSet {
            getInfo(text: productID!)
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initTableView()
        // Initialization code
    }

    
    func initTableView(){

        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        tableView.registerCell(identifier: StockTableViewCell.identifier)
        
        tableView.layoutIfNeeded()

        
        
    }
    
    
    
}


extension StockCollectionViewCell :  UITableViewDelegate, UITableViewDataSource {
   
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

       
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.stocks?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
            let cell = tableView.dequeueReusableCell(withIdentifier: StockTableViewCell.identifier, for: indexPath) as! StockTableViewCell

        cell.result = self.stocks![indexPath.row]
            cell.selectionStyle = .none

            return cell

            

        
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









extension StockCollectionViewCell {

    func getInfo(text:String) {
//        ProgressHUD.show()

    

        self.getHeader.executeStock(text: text).sink { completion in
            debugPrint("getUserProfileUseCase \(completion)")

        } receiveValue: { resp in
//            debugPrint("resp \(resp)")

            
            
            if let item = resp {
//                self.headerData = resp?.data
//                ProgressHUD.dismiss()

//                self.stocks = item.
                self.stocks = resp?.data?.result

                self.tableView.reloadData()
                
//                let indexPath = IndexPath(item: 0, section: 0)
//                self.tableView.reloadRows(at: [indexPath], with: .none)
//                self.getNews()
            }
        }.store(in: &self.anyCancellable)
    }
}
