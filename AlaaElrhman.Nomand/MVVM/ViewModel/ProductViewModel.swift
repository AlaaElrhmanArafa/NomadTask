//
//  ProductViewModel.swift
//  AlaaElrhman.Nomand
//
//  Created by AlaaElrhman on 16/10/2022.
//

import Foundation
import UIKit

struct ProductViewModel{
    
    var image:URL?
    var title:String?
    var price:String?
    var product:Product?
    var id:String?
    var qty:String = ""
    
    init(product:Product){
        if let url = URL(string: product.imageURL ?? ""){
            image = url
        }
        
        if let price = product.retailPrice{
            self.price = "\(price) $"
        }else{
            self.price = ""
        }
        
        title = product.name
        self.product = product
        id = product.id
    }
    
    init(productdb:ProductDB){
        if let url = URL(string: productdb.imageURL ?? ""){
            image = url
        }
        
        self.price = "\(productdb.price) $"
        
        title = productdb.name
        id = productdb.id
        qty = "Qty: \(productdb.qty)"
    }
}
