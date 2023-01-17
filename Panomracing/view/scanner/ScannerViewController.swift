//
//  ScannerViewController.swift
//  Panomracing
//
//  Created by Ssoft_dev on 8/23/22.
//

import UIKit
import AVFoundation
import QRCodeReader


class ScannerViewController: UIViewController,QRCodeReaderViewControllerDelegate{

    
    
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
            
            // Configure the view controller (optional)
            $0.showTorchButton        = false
            $0.showSwitchCameraButton = false
            $0.showCancelButton       = false
            $0.showOverlayView        = true
            $0.rectOfInterest         = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
    }
    

    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        
    }
    

}
