//
//  HomeListViewModel.swift
//  AlaaElrhman.Nomad
//
//  Created by AlaaElrhman on 15/10/2022.
//

import Foundation

class HomeListViewModel{
    //MARK: - variables -
    private var products: [Product] = []
    private var productsVMs = [ProductViewModel]()
    
    var reloadTableViewClosure: (()->())?
    var showAlertClosure: ((_ msg:String)->())?
    var isLoading: ((_ status:Bool)->())?
    
    var count:Int{
        return productsVMs.count
    }
    
    func viewModel(for indexPath:IndexPath) -> ProductViewModel{
        return productsVMs[indexPath.row]
    }
        
    //MARK: - APICall -
    func getProducts(){
        isLoading?(true)
        DispatchQueue.global().async {
            RequestManager.defaultManager.WebServiceApiRequest(service: Endpoints.products, parameters: "") {[weak self] (products:ProductsResponse?, error) in
                self?.isLoading?(false)
                if error != nil{
                    self?.showAlertClosure?(error?.localizedDescription ?? "error occurd")
                    return
                }
                if let products = products{
                    self?.products = products.map{$0.value}
                    self?.productsVMs = self?.products.map({ProductViewModel(product: $0)}) ?? []
                    self?.reloadTableViewClosure?()
                }
            }
        }
    }
    
    func addProduct(for product:Product){
        isLoading?(true)
        DataBaseManegar.sharedDB.saveToCoreData(model: product){ [weak self] success in
            self?.isLoading?(false)
            if !success{
                self?.showAlertClosure?("Failed to add items")
            }
        }
    }
}
