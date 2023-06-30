//
//  OrdersProtocol.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 16/05/23.
//

import Foundation
import UIKit

protocol OrdersPresenterToViewProtocol: AnyObject {
    var viewFinishedContainer: GeneralCustomView! {get set}
    var viewCancelContainer: GeneralCustomView! {get set}
    var viewPendingContainer: GeneralCustomView! {get set}
    var viewCreateContainer: GeneralCustomView! {get set}
    var txtFromDate: UITextField! {get set}
    var txtToDate: UITextField! {get set}
    var viewDateFilter: UIView! {get set}
    var lblTitleTable: UILabel! {get set}
    var tableView: UITableView! {get set}
    var viewAdd: GeneralCustomView! {get set}
    var filterSegmentControl: UISegmentedControl! {get set}
    
    func reloadTable(data: [OrderModel])
}

protocol OrdersInteractorToPresenterProtocol: AnyObject {
    func fetchedDataSuccess(_ model: OrdersResponse)
    func fetchedDataSuccessClient(_ model: ClientResponse)
    func fetchedDataSuccessFilterStatus(_ model: OrdersResponse)
    func fetchedDataSuccessOrder(_ model: OrdersResponse)
    func fetchedDataError(_ error: Error)
}

protocol OrdersPresenterToInteractorProtocol: AnyObject {
    var presenter: OrdersInteractorToPresenterProtocol? {get set}
    func prepareResponseForModel()
    func prepareResponseSaveOrder(userID: Int, clientID: Int, orderDate: String, deliveryDate:String, statusID: Int)
    func prepareResponseClient()
    func prepareResponseFilterStatus(_ statusId: Int, _ fromDate: String,_ toDate:String)
}

protocol OrdersViewToPresenterProtocol: AnyObject {
    var view: OrdersPresenterToViewProtocol? {get set}
    var interactor: OrdersPresenterToInteractorProtocol? {get set}
    var router: OrdersPresenterToRouterProtocol? {get set}
    func updateView()
    func goAddProducts(_ index: Int,_ deliveryDate: String)
    func goNewOrder()
    func segmentedAction(_ indicator:Int)
    func changeLabels(_ code: String)
    func filterAction()
}

protocol OrdersPresenterToRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
    func goToAddProducts(_ origin: UIViewController?,_ delegate: delegateOrderAddProductProtocol, _ model: OrdersResponse)
}
