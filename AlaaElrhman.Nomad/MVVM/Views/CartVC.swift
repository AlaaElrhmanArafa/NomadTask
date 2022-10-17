//
//  CartVC.swift
//  AlaaElrhman.Nomad
//
//  Created by AlaaElrhman on 16/10/2022.
//

import UIKit

class CartVC: UIViewController {
    
    //MARK: - Outlets -
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet weak var activityIndicator:UIActivityIndicatorView!
    @IBOutlet weak var noProductsLabel: UILabel!
    
    lazy var viewModel = CartViewModel()

    //MARK: - LifeCycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
        initViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getCartItems()
    }
    
    //MARK: - init func -
    private func registerNibs(){
        productTableView.registerNibForTable(ofType: ProductTVCell.self)
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
                        self.productTableView.alpha = 0.0
                    })
                }else{
                    self.activityIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.productTableView.alpha = 1.0
                    })
                }
            }
        }
        
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.productTableView.reloadData()
                self?.noProductsLabel.isHidden = self?.viewModel.count != 0
            }
        }
        
        viewModel.updatePriceClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.totalPriceLabel.text = self?.viewModel.totalPrice
            }
        }
    }

}
//MARK: - tableViewDelegate -
extension CartVC:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueCellForTable(ofType: ProductTVCell.self)
        cell.viewModel = self.viewModel.viewModel(for: indexPath)
        cell.cartDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
extension CartVC: CartActionsButtonDelegate{
    func didAddQtyFor(id: String) {
        self.viewModel.addProductQty(for: id)
    }
    
    func didDeleteProduct(id: String) {
        self.viewModel.minProductQty(for: id)
    }
}
