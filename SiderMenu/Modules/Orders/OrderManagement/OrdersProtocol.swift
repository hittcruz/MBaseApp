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
    var txtFromDate: UITextField! {get set}
    var txtToDate: UITextField! {get set}
    var viewDateFilter: UIView! {get set}
    var lblTitleTable: UILabel! {get set}
    
    func reloadTable(data: [OrderModel])
}

protocol OrdersInteractorToPresenterProtocol: AnyObject {
    func fetchedDataSuccess(list: [OrderModel])
    func fetchedDataSuccessClient(_ model: ClientResponse)
    func fetchedDataSuccessOrder()
    func fetchedDataError(_ error: Error)
}

protocol OrdersPresenterToInteractorProtocol: AnyObject {
    var presenter: OrdersInteractorToPresenterProtocol? {get set}
    func prepareResponseForModel()
    func prepareResponseSaveOrder()
    func prepareResponseClient()
}

protocol OrdersViewToPresenterProtocol: AnyObject {
    var view: OrdersPresenterToViewProtocol? {get set}
    var interactor: OrdersPresenterToInteractorProtocol? {get set}
    var router: OrdersPresenterToRouterProtocol? {get set}
    func updateView()
    func goAddProducts(_ index: Int)
    func goNewOrder()
    func segmentedAction(_ indicator:Int)
    func changeLabels(_ item: orderOptions)
}

protocol OrdersPresenterToRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
    func goToAddProducts(_ origin: UIViewController?,_ delegate: delegateOrderAddProductProtocol)
}
