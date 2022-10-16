//
//  CoreDataManager.swift
//  AlaaElrhman.Nomand
//
//  Created by AlaaElrhman on 16/10/2022.
//

import Foundation
import CoreData
import UIKit

class DataBaseManegar {
    
    static let sharedDB  = DataBaseManegar()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var products = [ProductDB]()
    
    //MARK: - Save To Core Data
    //Product
    func saveToCoreData(model: Product, completion: @escaping((_ success:Bool) -> ())){
    
        if fetchProducts().contains(where: {$0.id == model.id }) {
            if let product = fetchProducts().filter({$0.id == model.id}).first{
                product.qty = product.qty + 1
            }
        }else{
            let product = NSEntityDescription.insertNewObject(forEntityName: "ProductDB", into: context)
            product.setValue(model.id ?? "" , forKey: "id")
            product.setValue(model.name ?? "" , forKey: "name")
            product.setValue(model.retailPrice ?? "" , forKey: "price")
            product.setValue(model.imageURL, forKey: "imageURL")
            product.setValue(1, forKey: "qty")
        }

        do{
            try context.save()
            print("saved")
            completion(true)
        }catch{
            print("error")
            completion(false)
        }
        
    }
    
    func saveExistingProduct(with id:String, completion: @escaping((_ success:Bool) -> ())){
        if let product = fetchProducts().filter({$0.id == id}).first{
            product.qty = product.qty + 1
        }
        do{
            try context.save()
            print("saved")
            completion(true)
        }catch{
            print("error")
            completion(false)
        }
    }
 
    //MARK: - Fetch Core Data
    func fetchProducts() -> [ProductDB]{
        do{
            return try context.fetch(ProductDB.fetchRequest()) as! [ProductDB]
        }catch{
            return []
        }
    }
 
    //MARK: -  Delete From Core Data -
    func delete(productID : String, completion: @escaping((_ success:Bool) -> ())) {
        let modelId = productID
        let fetched = fetchProducts()
        
        if let product = fetchProducts().filter({$0.id == productID}).first, product.qty > 1{
            product.qty = product.qty - 1
        }else{
            guard let index = fetched.first(where: {$0.id == modelId}) else { return }
            context.delete(index)
        }
        do{
            print("Deleted and Saved")
            try context.save()
            completion(true)
        }catch{
            print("error")
            completion(false)
        }
    }
    
    //MARK: - Delete All Records
    func deleteAllRecords(completion: @escaping((_ success:Bool) -> ())){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: "Products")
        requestDel.returnsObjectsAsFaults = false
        
        do {
            let arrUsrObj = try context.fetch(requestDel)
            for usrObj in arrUsrObj as! [NSManagedObject] { // Fetching Object
                context.delete(usrObj) // Deleting Object
            }
        } catch {
            print("Failed")
            completion(false)
        }
        
        do {
            try context.save()
            completion(true)
        } catch {
            print("Failed saving")
            completion(false)
        }
    }
}
