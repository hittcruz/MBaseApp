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
        lblOrder.text = "Pedido N°: \(order.numberOrder)"
        lblDate.text = "Fecha de entrega: \(order.delivery_date)"
        lblCount.text = "Cantidad: 2"
        lblTotal.text = "Total S/. \(order.amount)"
    }
    
}
