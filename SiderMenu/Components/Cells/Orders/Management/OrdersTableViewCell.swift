//
//  OrdersTableViewCell.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 15/05/23.
//

import UIKit

class OrdersTableViewCell: UITableViewCell {

    @IBOutlet weak var viewContainer: UIView!
    
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblOrder: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewContainer.borders(radius: 8)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func attachOrder(order: OrderModel){
        let client = order.client ?? "Cliente"
        let date = order.deliveryDate ?? "00/00/0000"
        let count = order.count ?? "0"
        let total = order.total ?? 0.00
        
        lblOrder.text = "Cliente: \(client)"
        lblDate.text = "Fecha de entrega: \(date)"
        lblCount.text = "Cantidad: \(count)"
        lblTotal.text = "Total S/. \(total)"
    }
    
}
