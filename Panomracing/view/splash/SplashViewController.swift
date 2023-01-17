//
//  SplashViewController.swift
//  Panomracing
//
//  Created by Ssoft_dev on 8/7/22.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationbar()
        print("dlep")
        if #available(iOS 13.0, *) {
            print("iOS 13.0")
               // Always adopt a light interface style.
               overrideUserInterfaceStyle = .light
           }
        overrideUserInterfaceStyle = .light

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {

            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc : ViewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            let navigationController = UINavigationController(rootViewController: vc)
            navigationController.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
            self.present(navigationController, animated: true, completion: nil)
   
        }
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension SplashViewController {
    
    
    func setupNavigationbar(){
        
        
        let nav  = self.navigationController!
//        self.title = "พนม เรซซิ่ง"
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

//            appearance.backgroundColor = UIColor(named: "primary")
            appearance.shadowColor = .clear
            appearance.shadowImage = UIImage()
            appearance.backgroundImage = UIImage()
//            appearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont.h2Text, NSAttributedString.Key.foregroundColor: UIColor.white]
//            nav.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

            nav.navigationBar.barStyle = .black
//            nav.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]

          //  navigationController?.navigationBar.titleTextAttributes = textAttributes
//            nav.navigationBar.tintColor = .white
            

            nav.navigationBar.scrollEdgeAppearance = appearance
            nav.navigationBar.standardAppearance = appearance
            nav.navigationBar.compactAppearance = appearance
//            nav.navigationBar.barTintColor = UIColor.purple
//            nav.navigationBar.tintColor = UIColor.white
            
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
}
    
