//
//  ProductDescViewController.swift
//  Panomracing
//
//  Created by Ssoft_dev on 8/8/22.
//

import UIKit
import HMSegmentedControl


class ProductDescViewController: UIViewController {

    
    //Segment
    @IBOutlet weak var topNav: UIView!
    let segmentedControl = HMSegmentedControl()
    var currentPage: Int = 0
    var barcodeText:String = ""
    var barcodeState:Bool = false

    
    @IBOutlet var pageCollectionView: UICollectionView!
    
    
    var productID:String? 
    // ViewModel
//    lazy var viewModel: ForYouProtocol = {
//        let vm = ForYouViewModel(vc: self)
//        self.configure(vm)
//        self.bindToViewModel()
//        return vm
//    }()
//
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationbar()
        setupUI()
        setupTopnav()
        setupPageCollectionView()
        
//        let back_image = UIImage(named: "btn_back")
//        self.navigationBar.backIndicatorImage = back_image
//        self.navigationBar.backIndicatorTransitionMaskImage = back_image

        // Do any additional setup after loading the view.
    }
    

//    func configure(_ interface: ForYouProtocol) {
//        self.viewModel = interface
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        let nav  = self.navigationController!
        nav.navigationBar.barTintColor =  UIColor(named: "primary")!

//        self.navigationController.setBarTintColor(color: UIColor(named: "primary")!)
        pageCollectionView.reloadData()
    }


}


// MARK: - Binding
extension ProductDescViewController {
    func bindToViewModel() {
    }
}

extension ProductDescViewController {
    
    func setupUI() {
    }
    
    private func setupTopnav() {

        segmentedControl.sectionTitles = [
            "ทั่วไป",
            "คลัง"
        ]
        
        segmentedControl.frame = CGRect(x: 0, y: 8, width: topNav.frame.width, height: 38)
        segmentedControl.selectionIndicatorLocation = .bottom
        segmentedControl.selectionIndicatorColor = UIColor(named: "primary")!
        segmentedControl.autoresizingMask = [.flexibleRightMargin, .flexibleWidth]
        segmentedControl.selectionStyle = .fullWidthStripe
        segmentedControl.contentVerticalAlignment = .center
        segmentedControl.enlargeEdgeInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        segmentedControl.segmentEdgeInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        segmentedControl.selectionIndicatorHeight = 3
        segmentedControl.selectedTitleTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor(named: "primary")!, NSAttributedString.Key.font: UIFont(name: "Sarabun-Medium", size: 16.0)! ]
        segmentedControl.titleTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont(name: "Sarabun-Medium", size: 16.0)! ]
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlChangedValue(segmentedControl:)), for: .valueChanged)
        view.addSubview(segmentedControl)
        topNav.addSubview(segmentedControl)
    }
    
    @objc func segmentedControlChangedValue(segmentedControl: HMSegmentedControl) {
        let selectedSegmentIndex = segmentedControl.selectedSegmentIndex
        let selectedIndexPath = IndexPath(item: Int(selectedSegmentIndex), section: 0)
        pageCollectionView.scrollToItem(at: selectedIndexPath, at: .bottom, animated: true)
    }
}

//MARK:- PageCollectionView
extension ProductDescViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func setupPageCollectionView() {

        pageCollectionView.delegate = self
        pageCollectionView.dataSource = self
        pageCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        pageCollectionView.showsHorizontalScrollIndicator = false
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        layout.sectionInsetReference = .fromSafeArea
        pageCollectionView.collectionViewLayout = layout
        pageCollectionView.contentInsetAdjustmentBehavior = .always
        pageCollectionView.isPagingEnabled = true
        pageCollectionView.backgroundColor = .clear

        pageCollectionView.registerCell(identifier: InfoCollectionViewCell.identifier)
        pageCollectionView.registerCell(identifier: StockCollectionViewCell.identifier)

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoCollectionViewCell.identifier, for: indexPath) as! InfoCollectionViewCell
            cell.barcodeText = self.barcodeText
            cell.barcodeState = self.barcodeState
            cell.productID = self.productID!
           
            return cell
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StockCollectionViewCell.identifier, for: indexPath) as! StockCollectionViewCell
            cell.productID = self.productID!
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    

//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return viewModel.output.getNumberOfItemsInSection(collectionView, section: section)
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        return viewModel.output.getCellForItemAt(collectionView, indexPath: indexPath)
//    }
//
//
//
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

//
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: pageCollectionView.frame.width, height: pageCollectionView.frame.height)
    }
//
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = view.frame.width
        let currentPage = UInt(pageCollectionView.contentOffset.x/pageWidth)
        segmentedControl.setSelectedSegmentIndex(currentPage, animated: true)
    }
}

extension ProductDescViewController {
    
    
    func setupNavigationbar(){
        
        
        let nav  = self.navigationController!
        self.title = "รายละเอียดสินค้า"
//        nav.tintColor = UIColor.white

        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
        
            appearance.backgroundColor = UIColor(named: "primary")
            appearance.shadowColor = .clear
            appearance.shadowImage = UIImage()
            appearance.backgroundImage = UIImage()
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//            nav.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

            nav.navigationBar.barStyle = .black
//            nav.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
          //  navigationController?.navigationBar.titleTextAttributes = textAttributes
//            nav.navigationBar.tintColor = .white

            nav.navigationBar.scrollEdgeAppearance = appearance
            nav.navigationBar.standardAppearance = appearance
            nav.navigationBar.compactAppearance = appearance
            //nav.navigationBar.barTintColor = UIColor.purple
//            nav.navigationBar.tintColor = UIColor.white
            
            
//            nav.navigationBar.hidesBackButton = true
            
            let customBackButton = UIBarButtonItem(image: UIImage(named: "left-arrow") , style: .plain, target: self, action: #selector(backAction(sender:)))
                customBackButton.imageInsets = UIEdgeInsets(top: 0, left: -8, bottom: 10, right: 0)
            customBackButton.tintColor = UIColor.white

            
//            let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.bordered, target: self, action: "back:")
              self.navigationItem.leftBarButtonItem = customBackButton
            
            
        } else {
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
        
        
        let backButton = UIBarButtonItem(title: "back", style: UIBarButtonItem.Style.plain, target: navigationController, action: nil)
        nav.navigationItem.leftBarButtonItem = backButton
        
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
    
    @objc func backAction(sender: UIBarButtonItem) {
        // custom actions here
        print("lfep")
        dismiss(animated: true, completion: nil)

//        navigationController?.popViewController(animated: true)
    }
    
}
    
