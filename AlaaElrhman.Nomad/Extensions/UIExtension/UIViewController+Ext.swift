//
//  UIViewController+Ext.swift
//  AlaaElrhman.Nomad
//
//  Created by AlaaElrhman on 15/10/2022.
//

import Foundation
import UIKit

extension UIViewController{
    func alert(message: String, actionClosuer:(() -> ())? = nil){
        let alertView = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default) { (action) in
            // pop here
            actionClosuer?()
        }
        alertView.addAction(OKAction)
        DispatchQueue.main.async {
            self.present(alertView, animated: true, completion: nil)
        }
    }
}
