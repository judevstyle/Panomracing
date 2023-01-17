//
//  ViewController.swift
//  Panomracing
//
//  Created by Ssoft_dev on 8/7/22.
//

import UIKit

import Combine
//import SVPro
import ProgressHUD
import AVFoundation
import BarcodeEasyScan
import ScanCode
import Toast_Swift
class ViewController: UIViewController , UITextFieldDelegate,ScanBarcodeDelegate {
    func userDidScanWith(barcode: String) {
        
    }
    
//    func scanCode(_ scanCode: SGScanCode!, result: String!) {
//
//    }
//

    
    
    @IBOutlet weak var searchTF: DesignableUITextField!
    var products:[ProductItem]?
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var barcodeIM: UIImageView!
    
    var getHeader: ProductUseCase = ProductUseCaseImpl()
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()

    var barcodeState = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        searchTF.returnKeyType = UIReturnKeyType.search

        self.searchTF.delegate = self;
        self.setupNavigationbar()

        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))

       //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
       //tap.cancelsTouchesInView = false

//       view.addGestureRecognizer(tap)
        self.searchTF.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)),
                                  for: .editingChanged)
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
            
        if textField.text?.count == 0 {
            products = []
            tableView.reloadData()
        }
        
    }
    
    @objc  func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView

        print("ddd")
        // Your action
//        let barcodeViewController =  BarcodeScannerViewController()
//        barcodeViewController.delegate = self
//        self.present(barcodeViewController, animated: true, completion: {
//        })

        
        
        let mScanViewController = ScanViewController()
                if #available(iOS 13.0, *) {
                    mScanViewController.modalPresentationStyle = .fullScreen
                }
                weak var weakSelf = self
                mScanViewController.mScanBlockCallback = {
                    (scanCodeResult:String) in
                    // 注意：更新UI必须切换到主线程
                    DispatchQueue.main.async {

                        
                        weakSelf?.barcodeState  = true

                        print("fkooo \(scanCodeResult)")
                        weakSelf?.searchTF.text = "\(scanCodeResult)"
                        weakSelf?.getProduct(text: "\(scanCodeResult)")


                    }
                }
                self.present(mScanViewController, animated: true, completion: nil)
        
        
        
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          if textField == searchTF {
             //any task to perform
              getProduct(text: "\(textField.text!)")
//              print("ss \(textField.text!)")
             textField.resignFirstResponder() //if you want to dismiss your keyboard
          }
          return true
      }
    func initView(){
        
        barcodeIM.image = barcodeIM.image?.withRenderingMode(.alwaysTemplate)
        barcodeIM.tintColor = UIColor(named: "primary")
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        barcodeIM.isUserInteractionEnabled = true
        barcodeIM.addGestureRecognizer(tapGestureRecognizer)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        tableView.registerCell(identifier: ProductTableViewCell.identifier)
        
    }


}


extension ViewController :  UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let modalViewController = NotificationModalViewController()
//           modalViewController.modalPresentationStyle = .overCurrentContext
//        modalViewController.data = notifications![indexPath.row]
//
//        present(modalViewController, animated: true, completion: nil)
//
        
        
//        let storyboard = UIStoryboard.init(name: "ProductDesc", bundle: nil)
//               let secondVc = storyboard.instantiateViewController(withIdentifier: "ProductDescViewController") as! ProductDescViewController
////        secondVc.modalPresentationStyle = .overCurrentContext //or .overFullScreen for transparency
//        secondVc.modalTransitionStyle = .crossDissolve
//        navigationController.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
//
////        secondVc.data = notifications![indexPath.row]
//        self.present(secondVc, animated: true, completion: nil)
//
        let data = products![indexPath.row]
        
        let storyboard : UIStoryboard = UIStoryboard(name: "ProductDesc", bundle: nil)
        let vc : ProductDescViewController = storyboard.instantiateViewController(withIdentifier: "ProductDescViewController") as! ProductDescViewController
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        vc.productID = "\(data.Id!)"
        vc.barcodeState = barcodeState
        
        self.present(navigationController, animated: true, completion: nil)
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.products?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as! ProductTableViewCell
            cell.product = products![indexPath.row]
        cell.selectionStyle = .none

            return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
    
}


extension ViewController {

    func getProduct(text:String) {
        
        
        
        if text.count > 0 {
            ProgressHUD.show()

        }else{
            self.view.makeToast("ระบุคำค้นหา")

        }

    

        self.getHeader.executeProducts(text: text).sink { completion in
            debugPrint("getUserProfileUseCase \(completion)")
            print("dldldll")
            switch completion {
                           case .failure(let error):
                               print(error)
                                self.view.makeToast("ไม่พบข้อมูลการค้นหา")
                           case .finished:
                               print("SUCCESS ")
                           }
        } receiveValue: { resp in
//            debugPrint("resp \(resp)")

            
            
            if let item = resp {
//                self.headerData = resp?.data
                
                print("SUCCESS sss")

                
                if self.barcodeState && (resp?.data!.count)! > 0 {
                    let product = resp!.data![0]

                    let storyboard : UIStoryboard = UIStoryboard(name: "ProductDesc", bundle: nil)
                    let vc : ProductDescViewController = storyboard.instantiateViewController(withIdentifier: "ProductDescViewController") as! ProductDescViewController
                    let navigationController = UINavigationController(rootViewController: vc)
                    navigationController.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
                    vc.productID = "\(product.Id!)"
                    vc.barcodeState = self.barcodeState
                    vc.barcodeText = self.searchTF.text!
                    self.present(navigationController, animated: true, completion: nil)
                    
                    
                }
                
//
                if resp?.success == nil {
                    print("lepfkoo")
                    self.view.makeToast("ไม่พบข้อมูลการค้นหา")


                }
//
                
                ProgressHUD.dismiss()

                self.products = resp?.data
                
                
                
                
                
                self.tableView.reloadData()
                print("json \( resp?.data)")
                
//                let indexPath = IndexPath(item: 0, section: 0)
//                self.tableView.reloadRows(at: [indexPath], with: .none)
//                self.getNews()
            } else {
                print("ss err")


            }
        }.store(in: &self.anyCancellable)
    }
}



extension ViewController {
    
    
    func setupNavigationbar(){
        
        
        let nav  = self.navigationController!
        self.title = "พนม เรซซิ่ง"
//        nav.tintColor = UIColor.white
//        if #available(iOS 13.0, *) {
//               // Always adopt a light interface style.
//               overrideUserInterfaceStyle = .light
//           }
        if #available(iOS 15.0, *) {
            print("15.0")
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
//            appearance.unselectedItemTintColor = UIColor.green

//            appearance.configureWithOpaqueBackground()

            appearance.backgroundColor = UIColor(named: "primary")
            appearance.shadowColor = .clear
            appearance.shadowImage = UIImage()
            appearance.backgroundImage = UIImage()
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//            nav.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

//            nav.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]

          //  navigationController?.navigationBar.titleTextAttributes = textAttributes
//            nav.navigationBar.tintColor = .white
            

            nav.navigationBar.scrollEdgeAppearance = appearance
            nav.navigationBar.standardAppearance = appearance
            nav.navigationBar.compactAppearance = appearance
//            nav.navigationBar.barTintColor = UIColor.purple
//            nav.navigationBar.tintColor = UIColor.white
            nav.navigationBar.barStyle = .black

        } else {
            print(" < 15.0")

            nav.navigationBar.barTintColor = UIColor.purple
            nav.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

            nav.navigationBar.barTintColor = UIColor(named: "primary")
            nav.navigationBar.setBackgroundImage(UIImage(), for: UIBarPosition.bottom, barMetrics: .default)
            nav.navigationBar.shadowImage = UIImage()
            nav.navigationBar.isTranslucent = true
            nav.navigationBar.isHidden = true
            nav.navigationBar.barStyle = .black
            nav.navigationBar.tintColor = .white
            nav.navigationBar.layoutIfNeeded()
          
        }
        
//        if #available(iOS 13.0, *) {
//              switch AppState.appThemeStyle {
//              case "dark":
//                  window?.overrideUserInterfaceStyle = .dark
//                  break
//              case "light":
//                  window?.overrideUserInterfaceStyle = .light
//                  break
//              default:
//                  window?.overrideUserInterfaceStyle = .unspecified
//              }
//          }
        
//        let image = UIImage(named: "logo_icons") //Your logo url here
//           let imageView = UIImageView(image: image)

//        let bannerWidth = nav.navigationBar.frame.size.width
//                let bannerHeight = nav.navigationBar.frame.size.height
//
//        let bannerX = bannerWidth / 2 - (image?.size.width)! / 2
//              let bannerY = bannerHeight / 2 - (image?.size.height)! / 2
//              imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
//              imageView.contentMode = .scaleAspectFit
//
//        let logoImage = UIImage.init(named: "logo_icons")
//            let logoImageView = UIImageView.init(image: logoImage)
//            logoImageView.frame = CGRect(x: -140, y: 0, width: 0, height: 0)//CGRectMake(-40, 0, 150, 25)
//        logoImageView.contentMode = .scaleAspectFit
//        let imageItem = UIBarButtonItem.init(customView: logoImageView)
//        let negativeSpacer = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)

        
//            let logoImage = UIImage.init(named: "logo_icons")
//           let logoImageView = UIImageView.init(image: logoImage)
//           logoImageView.frame = CGRect(x:0.0,y:0.0, width:60,height:25.0)
//           logoImageView.contentMode = .scaleAspectFit
//           let imageItem = UIBarButtonItem.init(customView: logoImageView)
//           let widthConstraint = logoImageView.widthAnchor.constraint(equalToConstant: 60)
//           let heightConstraint = logoImageView.heightAnchor.constraint(equalToConstant: 40)
//            heightConstraint.isActive = true
//            widthConstraint.isActive = true
//
//        navigationItem.leftBarButtonItem = imageItem
        //righ menu
        
        
   
//        setLang()
//        let btnLogo = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
//        btnLogo.backgroundColor = UIColor.clear
//        btnLogo.layer.cornerRadius = 4.0
//        btnLogo.layer.masksToBounds = true
//
//        var imageLogo = UIImage(named: "ic_notification")
//        imageLogo = imageLogo?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
//        btnLogo.setImage(imageLogo, for: .normal)
//
//        let barButton = UIBarButtonItem(customView: btnLogo)
//        self.navigationItem.rightBarButtonItem = barButton
        
        
        
//        let myimage = UIImage(named: "ic_notification")?.withRenderingMode(.alwaysOriginal)
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: myimage, style: .plain, target: self, action: #selector(ButtonTapped))

        
        
        
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
           .lightContent
       }
}
    
extension ViewController{
    
  
//    func userDidScanWith(barcode: String) {
//
//        print("barcode \(barcode)")
//        return
//
//    }
//
 
    
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear")
        barcodeState = false
    }
 
  
}

