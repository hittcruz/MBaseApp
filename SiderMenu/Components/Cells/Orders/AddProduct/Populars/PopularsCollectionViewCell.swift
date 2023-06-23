//
//  PopularsCollectionViewCell.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 14/06/23.
//

import UIKit

class PopularsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblSymbol: UILabel!
    @IBOutlet weak var lblPreci: UILabel!
    @IBOutlet weak var viewAddProduct: GeneralCustomView!
    
    var delegate : delegateTapProducts?
    
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
    
    func displayPopulars(item: Products){
        lblTitle.text = item.name ?? ""
        lblDescription.text = item.description ?? ""
        lblPreci.text = String(item.unitPreci?.rounded(toPlaces: 2) ?? 0.00)
//        if let image = item.image {
//            imgProduct.image = UIImage(named: image)
//        }
    }

}
