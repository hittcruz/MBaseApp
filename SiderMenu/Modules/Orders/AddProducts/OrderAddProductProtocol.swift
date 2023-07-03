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
    var containerPopulars: GeneralCustomView! {get set}
    var productsData: [Products] {get set}
    var categoriesData: [Category] {get set}
    var popularsData: [Products] {get set}
    var labelPreci: UILabel {get set}
    var labelCant: UILabel {get set}
    var carView: UIView {get set}
    
    func createCart()
    func reloadData()
}

protocol OrderAddProductInteractorToPresenterProtocol: AnyObject {
    func fetchedDataSuccess(model: ProductResponse)
    func fetchedDataSuccessCategory(_ model: CategorieResponse)
    func fetchedDataSuccessAddProduct(_ model: CartModel)
    func fetchedDataSuccessShowCart(_ model: CartModel)
    func fetchedDataSuccessFilter(_ model: FilterModel)
    func fetchedDataSuccessRemoveAll(_ msg: String)
    func fetchedDataError(_ error: Error)
}

protocol OrderAddProductPresenterToInteractorProtocol: AnyObject {
    var presenter: OrderAddProductInteractorToPresenterProtocol? {get set}
    func prepareResponseForModel()
    func prepareShowCart(_ orderId :Int)
    func prepareResponseAddProduct(_ orderId:Int,_ productID: Int,_ preci: Double)
    func prepareResponseRemoveAllProduct(_ orderId: Int)
    func prepareResponseFilter(_ categorieId: Int)
    func prepareResponseCategory()
}

protocol OrderAddProductViewToPresenterProtocol: AnyObject {
    var view: OrderAddProductPresenterToViewProtocol? {get set}
    var interactor: OrderAddProductPresenterToInteractorProtocol? {get set}
    var router: OrderAddProductPresenterToRouterProtocol? {get set}
    var modelOrder: OrderModel? {get set}
    
    func updateView()
    func seeAll()
    func addProduct(_ index: Int)
    func removeAllProducts()
    func saveProduct(_ list: [String])
    func filterProductsforCategory(_ index: Int)
}

protocol OrderAddProductPresenterToRouterProtocol: AnyObject {
    static func createModule(_ delegate: delegateOrderAddProductProtocol) -> UIViewController
    static func createModule(_ modelOrder: OrderModel) -> UIViewController
    func goToOrders(_ origin: UIViewController?)
}
