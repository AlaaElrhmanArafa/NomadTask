//
//  ProductTVCell.swift
//  AlaaElrhman.Nomand
//
//  Created by AlaaElrhman on 15/10/2022.
//

import UIKit

protocol CartActionsButtonDelegate{
    func didAddQtyFor(id:String)
    func didDeleteProduct(id:String)
}

protocol AddToCartDelegate{
    func didAddToCart(product:Product)
}

class ProductTVCell: UITableViewCell {
    
    //MARK: - Outlets and var -
    static let cellID = "ProductTVCell"

    @IBOutlet weak var qtyLabel: UILabel!
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var minusButton: UIButton!
    
    var viewModel:ProductViewModel?{
        didSet{
            productNameLabel.text = viewModel?.title
            productPriceLabel.text = viewModel?.price
            if let imageData = viewModel?.image{
                productImageView.load(url: imageData)
            }
            qtyLabel.text = viewModel?.qty
            minusButton.isHidden = viewModel?.qty == ""
        }
    }
    
    var addDelegate:AddToCartDelegate?
    var cartDelegate:CartActionsButtonDelegate?


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func cartButtonPressed(_ sender: Any) {
        if let product = self.viewModel?.product {
            self.addDelegate?.didAddToCart(product: product)
        }else if let id = viewModel?.id, viewModel?.qty != ""{
            self.cartDelegate?.didAddQtyFor(id: id)
        }
    }
    
    @IBAction func minusButtonPressed(_ sender: Any) {
        if let id = viewModel?.id, viewModel?.qty != ""{
            self.cartDelegate?.didDeleteProduct(id: id)
        }
    }
}
