//
//  OrderAddProductProtocol.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 16/05/23.
//

import Foundation
import UIKit

protocol OrderAddProductPresenterToViewProtocol: AnyObject {
    var bottomConstraint: NSLayoutConstraint! {get set}
    var productsData: [Products] {get set}
    var categoriesData: [Category] {get set}
    var popularsData: [Products] {get set}
    
    func createCart(_ model: CartModel)
    func reloadData()
}

protocol OrderAddProductInteractorToPresenterProtocol: AnyObject {
    func fetchedDataSuccess(model: ProductResponse)
    func fetchedDataSuccessCategory(_ model: CategorieResponse)
    func fetchedDataSuccessAddProduct(list: [String])
    func fetchedDataError()
}

protocol OrderAddProductPresenterToInteractorProtocol: AnyObject {
    var presenter: OrderAddProductInteractorToPresenterProtocol? {get set}
    func prepareResponseForModel()
    func prepareResponseAddProduct()
    func prepareResponseCategory()
}

protocol OrderAddProductViewToPresenterProtocol: AnyObject {
    var view: OrderAddProductPresenterToViewProtocol? {get set}
    var interactor: OrderAddProductPresenterToInteractorProtocol? {get set}
    var router: OrderAddProductPresenterToRouterProtocol? {get set}
    func updateView()
    func addProduct(_ index: Int)
    func saveProduct(_ list: [String])
}

protocol OrderAddProductPresenterToRouterProtocol: AnyObject {
    static func createModule(_ delegate: delegateOrderAddProductProtocol) -> UIViewController
    static func createModule() -> UIViewController
    func goToOrders(_ origin: UIViewController?)
}
