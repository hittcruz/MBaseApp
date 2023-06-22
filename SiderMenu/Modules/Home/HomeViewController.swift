//
//  HomeViewController.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 12/05/23.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBOutlet weak var lblTotalOrders: UILabel!
    @IBOutlet weak var lblTotalClients: UILabel!
    @IBOutlet weak var clientsView: GeneralCustomView!
    @IBOutlet weak var ordersView: GeneralCustomView!
    @IBOutlet weak var tableView: UITableView!
    
    public init() {
        super.init(nibName: "HomeViewController", bundle: Bundle(for: HomeViewController.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configInitial()
    }
    
    func configInitial(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func goOrdersAction(_ sender: Any) {
        print("vamos a pedidos")
        ordersView.handleTap()
        lblTotalOrders.flicker()
        
        if let nav = self.navigationController as? NavigationViewController {
            nav.setViewControllers([OrdersRouter.createModule()], animated: true)
        }
    }
    
    @IBAction func goClientsAction(_ sender: Any) {
        print("vamos a clientes")
        clientsView.handleTap()
        lblTotalClients.flicker()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellReuseIdentifier = "HomeDeliveryTableViewCell"
        tableView.register(UINib(nibName: "HomeDeliveryTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath ) as? HomeDeliveryTableViewCell else { return UITableViewCell()}
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(" did \(indexPath.row)")
    }
    
}
