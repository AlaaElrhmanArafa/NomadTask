//
//  HomeVC.swift
//  AlaaElrhman.Nomad
//
//  Created by AlaaElrhman on 15/10/2022.
//

import UIKit

class HomeVC: UIViewController {
    
    //MARK: - Outlets -
    @IBOutlet weak var productsTableView: UITableView!
    @IBOutlet weak var activityIndicator:UIActivityIndicatorView!
    @IBOutlet weak var noProductsLabel: UILabel!

    lazy var viewModel = HomeListViewModel()
    
    //MARK: - LifeCycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
        initViewModel()
    }
    
    //MARK: - init func -
    private func registerNibs(){
        productsTableView.registerNibForTable(ofType: ProductTVCell.self)
    }
    
    private func initViewModel(){
        viewModel.showAlertClosure = { [weak self] (msg) in
            DispatchQueue.main.async {
                self?.alert(message: msg)
            }
        }
        
        viewModel.isLoading = { [weak self] (isLoading) in
            guard let self = self else {
                return
            }

            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                if isLoading{
                    self.activityIndicator.startAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.productsTableView.alpha = 0.0
                    })
                }else{
                    self.activityIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.productsTableView.alpha = 1.0
                    })
                }
            }
        }
        
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.productsTableView.reloadData()
                self?.noProductsLabel.isHidden = self?.viewModel.count != 0
            }
        }
        
        viewModel.getProducts()
    }
    

}
//MARK: - tableViewDelegate -
extension HomeVC:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueCellForTable(ofType: ProductTVCell.self)
        cell.viewModel = self.viewModel.viewModel(for: indexPath)
        cell.addDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
extension HomeVC:AddToCartDelegate{
    func didAddToCart(product: Product) {
        self.viewModel.addProduct(for: product)
    }
}
