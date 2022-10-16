//
//  CartViewModel.swift
//  AlaaElrhman.Nomand
//
//  Created by AlaaElrhman on 16/10/2022.
//

import Foundation
import CoreData

class CartViewModel{
    private var products: [ProductDB] = []
    private var productsVMs = [ProductViewModel]()
    
    var reloadTableViewClosure: (()->())?
    var updatePriceClosure: (()->())?
    var showAlertClosure: ((_ msg:String)->())?
    var isLoading: ((_ status:Bool)->())?
    
    var count:Int{
        return productsVMs.count
    }
    
    var totalPrice:String{
        let totalPrice = products.reduce(0, {$0 + $1.price * $1.qty})
        return "\(totalPrice)"
    }
    
    func viewModel(for indexPath:IndexPath) -> ProductViewModel{
        return productsVMs[indexPath.row]
    }
    
    func getCartItems(){
        isLoading?(true)
        products = DataBaseManegar.sharedDB.fetchProducts()
        productsVMs = products.map({ProductViewModel(productdb: $0)})
        isLoading?(false)
        reloadTableViewClosure?()
        updatePriceClosure?()
    }
    
    func addProductQty(for id:String){
        isLoading?(true)
        DataBaseManegar.sharedDB.saveExistingProduct(with: id) { [weak self] success in
            self?.isLoading?(false)
            if !success{
                self?.showAlertClosure?("Failed to add items")
            }else{
                self?.getCartItems()
            }
        }
    }
    
    func minProductQty(for id:String){
        isLoading?(true)
        DataBaseManegar.sharedDB.delete(productID: id) { [weak self] success in
            self?.isLoading?(false)
            if !success{
                self?.showAlertClosure?("Failed to add items")
            }else{
                self?.getCartItems()
            }
        }
    }
}
