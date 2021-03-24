//
//  CollectionViewExtension.swift
//  RelaxNow
//
//  Created by Pritrum on 04/03/21.
//

import UIKit
extension UICollectionView {
    func registerCell(identifier:String)  {
        self.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
}

extension UITableView {
    func registerTableCell(identifier:CellIdentifier)  {
        self.register(UINib(nibName: identifier.rawValue, bundle: nil), forCellReuseIdentifier: identifier.rawValue)
    }
}
