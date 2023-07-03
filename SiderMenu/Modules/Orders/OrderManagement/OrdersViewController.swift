//
//  OrdersViewController.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 12/05/23.
//

import UIKit

class OrdersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewAdd: GeneralCustomView!
    
    @IBOutlet weak var lblTitleTable: UILabel!
    @IBOutlet weak var viewFinishedContainer: GeneralCustomView!
    @IBOutlet weak var viewCancelContainer: GeneralCustomView!
    @IBOutlet weak var viewPendingContainer: GeneralCustomView!
    @IBOutlet weak var viewCreateContainer: GeneralCustomView!
    
    @IBOutlet weak var filterSegmentControl: UISegmentedControl!
    @IBOutlet weak var applyFilterButton: CustomButton!
    @IBOutlet weak var viewDateFilter: UIView!
    @IBOutlet weak var txtFromDate: UITextField!
    @IBOutlet weak var txtToDate: UITextField!
    
    //Variables
    var presenter: OrdersViewToPresenterProtocol?
    var orderList: [OrderModel]?

    public init() {
        super.init(nibName: "OrdersViewController", bundle: Bundle(for: OrdersViewController.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        presenter?.updateView()
    }
    
    @IBAction func newOrderAction(_ sender: Any) {
        viewAdd.handleTap()
        print("Vamos a la vista de nuevo pedidos")
        presenter?.goNewOrder()
    }
    
    @IBAction func chargePendingAction(_ sender: UIButton) {
        let item = ConstantsPrivate.orderOptions.allCases[sender.tag].rawValue
        viewPendingContainer.handleTap()
        presenter?.changeLabels(item)
    }
    
    @IBAction func chargeCancelAction(_ sender: UIButton) {
        let item = ConstantsPrivate.orderOptions.allCases[sender.tag].rawValue
        viewCancelContainer.handleTap()
        presenter?.changeLabels(item)
    }
    
    @IBAction func chargeFinishAction(_ sender: UIButton) {
        let item = ConstantsPrivate.orderOptions.allCases[sender.tag].rawValue
        viewFinishedContainer.handleTap()
        presenter?.changeLabels(item)
    }
    
    @IBAction func chargeCreateAction(_ sender: UIButton) {
        viewCreateContainer.handleTap()
        presenter?.changeLabels("")
    }
    
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        presenter?.segmentedAction(sender.selectedSegmentIndex)
    }
    
    @IBAction func filterAction(_ sender: Any) {
        presenter?.filterAction()
    }
    
    @IBAction func addBeginTextField(_ sender: Any) {
        txtFilterFrom = txtFromDate
    }
    
    @IBAction func addBeginToTextField(_ sender: Any) {
        txtFilterTo = txtToDate
    }
}

extension OrdersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellReuseIdentifier = "OrdersTableViewCell"
        tableView.register(UINib(nibName: "OrdersTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath ) as? OrdersTableViewCell else { return UITableViewCell()}
        cell.selectionStyle = .none
        if let data = orderList?[indexPath.row] {
            cell.attachOrder(order: data)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let model = orderList?[indexPath.row]{
            presenter?.goNextCart(model)
        }
    }
}

extension OrdersViewController: OrdersPresenterToViewProtocol {
    func reloadTable(data: [OrderModel]) {
        orderList = data
        tableView.reloadData()
    }
}
