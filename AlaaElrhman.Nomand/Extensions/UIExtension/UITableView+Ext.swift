//
//  UITableView+Ext.swift
//  AlaaElrhman.Nomand
//
//  Created by AlaaElrhman on 15/10/2022.
//

import Foundation
import UIKit

extension UITableView {
    func registerNibForTable<T: UITableViewCell>(ofType type: T.Type) {
        let cellName = String(describing: T.self)
        
        if Bundle.main.path(forResource: cellName, ofType: "nib") != nil {
            let nib = UINib(nibName: cellName, bundle: Bundle.main)
            
            register(nib, forCellReuseIdentifier: cellName)
        } else {
            register(T.self, forCellReuseIdentifier: cellName)
        }
    }
    public func dequeueCellForTable<Cell: UITableViewCell>(ofType type: Cell.Type) -> Cell {
        let identifier = String(describing: Cell.self)

        guard let cell = self.dequeueReusableCell(withIdentifier: identifier) as? Cell else {
            
            fatalError("Error in cell")
        }
        return cell
    }
    
    func registerHeaderForTable<T: UITableViewHeaderFooterView>(ofType type: T.Type) {
        let cellName = String(describing: T.self)
        
        if Bundle.main.path(forResource: cellName, ofType: "nib") != nil {
            let nib = UINib(nibName: cellName, bundle: Bundle.main)
            
            register(nib, forHeaderFooterViewReuseIdentifier: cellName)
        } else {
            register(T.self, forHeaderFooterViewReuseIdentifier: cellName)
        }
    }
    public func dequeueHeaderForTable<Cell: UITableViewHeaderFooterView>(ofType type: Cell.Type) -> Cell {
        let identifier = String(describing: Cell.self)
        
        guard let header = self.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? Cell else {
            fatalError("Error in header")
        }
        return header
    }
    
    func configureTable(withSeparator: Bool) {
        self.separatorInset = .zero
        self.contentInset = .zero
        if withSeparator == true {
            self.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 1))
            self.separatorStyle = .singleLine
        }else{
            self.separatorStyle = .none
        }
        
    }
}

extension UITableViewCell {
    func shadowDecorate() {
        let radius: CGFloat = 0
        contentView.layer.cornerRadius = radius
        contentView.layer.borderWidth = 0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 1.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        layer.cornerRadius = radius
    }
}
