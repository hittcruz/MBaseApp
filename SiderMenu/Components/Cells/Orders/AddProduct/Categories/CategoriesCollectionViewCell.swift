//
//  CategoriesCollectionViewCell.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 14/06/23.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: GeneralCustomView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    static var cellType: String {
        return String(describing: self)
    }
    
    func displayCategories(item: Category){
        lblTitle.text = item.description ?? ""
        if let description = item.description {
            let icon = CategorieOption(rawValue: description)?.imageName
            imgView.image = UIImage(named: icon ?? "")
        }
    }
}
