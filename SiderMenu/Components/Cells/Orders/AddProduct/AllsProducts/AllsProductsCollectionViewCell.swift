//
//  AllsProductsCollectionViewCell.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 14/06/23.
//

import UIKit

protocol delegateTapProducts {
    func tapAddProduct(index: Int)
}

class AllsProductsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var lblPreci: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblProduct: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    
    @IBOutlet weak var viewAddProduct: GeneralCustomView!
    
    var index: Int = 0
    var delegate : delegateTapProducts?
    
    override func layoutSubviews() {
        imgProduct.round()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(taphandleProduct))
        viewAddProduct.addGestureRecognizer(tapGestureRecognizer)
    }
    
    static var cellType: String {
        return String(describing: self)
    }

    @objc func taphandleProduct() {
        viewAddProduct.handleTap()
        delegate?.tapAddProduct(index: viewAddProduct.tag)
    }
    
    func displayProducts(item: Products){
        lblProduct.text = item.name ?? ""
        lblDescription.text = item.description ?? ""
        lblPreci.text = String(item.unitPreci ?? 0.0)
//        if let image = item.image {
//            imgProduct.image = UIImage(named: image)
//        }
    }

}
