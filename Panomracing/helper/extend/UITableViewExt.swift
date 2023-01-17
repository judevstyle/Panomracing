//
//  UITableViewExt.swift
//  Panomracing
//
//  Created by Ssoft_dev on 8/8/22.
//

import Foundation
import UIKit

extension UITableView {
    func registerCell(identifier: String) {
        self.register(UINib.init(nibName: identifier, bundle: Bundle.main), forCellReuseIdentifier: identifier)
    }
}
