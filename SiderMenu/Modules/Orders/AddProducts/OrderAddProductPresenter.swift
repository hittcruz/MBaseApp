//
//  OrderAddProductPresenter.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 16/05/23.
//

import Foundation
import UIKit

protocol delegateOrderAddProductProtocol: AnyObject {
    func valueEntered(data: [String])
}

class OrderAddProductPresenter : OrderAddProductViewToPresenterProtocol {
    var view: OrderAddProductPresenterToViewProtocol?
    var interactor: OrderAddProductPresenterToInteractorProtocol?
    var router: OrderAddProductPresenterToRouterProtocol?
    
    weak var delegate: delegateOrderAddProductProtocol?
    
    let constantBottomShowCart:CGFloat = 58
    let constantBottomCloseCart:CGFloat = 8
    
    convenience init(delegate: delegateOrderAddProductProtocol) {
        self.init()
        self.delegate = delegate
    }
    
    func updateView() {
        initialConfiguration()
        seeAll()
        let orderId = 5
        interactor?.prepareShowCart(orderId)
    }
    
    private func initialConfiguration(){
        view?.bottomConstraint.constant = constantBottomCloseCart
        view?.createCart()
        view?.carView.isHidden = true
        
    }
    
    func addProduct(_ index: Int) {
        let item = view?.productsData[index]
        let orderId = 5
        interactor?.prepareResponseAddProduct(orderId, item?.id ?? 0, item?.unitPreci ?? 0.0)
    }
    
    func removeAllProducts() {
        view?.bottomConstraint.constant = constantBottomCloseCart
        view?.carView.isHidden = true
        let orderId = 5
        interactor?.prepareResponseRemoveAllProduct(orderId)
    }
    
    func seeAll() {
        interactor?.prepareResponseCategory()
        interactor?.prepareResponseForModel()
    }
    
    func saveProduct(_ list: [String]) {
        
       // self.delegate?.valueEntered(data: list)
        
//        guard let vc = view as? UIViewController else { return }
//        vc.navigationController?.popViewController(animated: true)
//        vc.navigationController?.popToViewController(OrdersRouter.createModule(), animated: true)
        
//        interactor?.prepareResponseAddProduct()
    }
    
    func filterProductsforCategory(_ index: Int) {
        interactor?.prepareResponseFilter(index)
    }
    
}

extension OrderAddProductPresenter: OrderAddProductInteractorToPresenterProtocol {
    func fetchedDataSuccessCategory(_ model: CategorieResponse) {
        if let categories = model.categories {
            view?.categoriesData = categories.sorted { $0.description ?? "" < $1.description ?? ""}
        }
        view?.reloadData()
    }
    
    func fetchedDataSuccess(model: ProductResponse) {
        if let populars = model.populars {
            if populars.count > 0{
                view?.popularsData = populars
                view?.containerPopulars.isHidden = false
            }else{
                view?.containerPopulars.isHidden = true
            }
        }
        
        if let produtcs = model.products {
            view?.productsData = produtcs
        }
        view?.reloadData()
    }
    
    func fetchedDataSuccessShowCart(_ model: CartModel) {
        let count = model.count ?? 0
        if count > 0{
            view?.bottomConstraint.constant = constantBottomShowCart
            view?.carView.isHidden = false
            view?.labelPreci.text = model.total?.rounded(toPlaces: 2).description
            view?.labelCant.text = model.count?.description
        }else{
            view?.bottomConstraint.constant = constantBottomCloseCart
            view?.carView.isHidden = true
        }
    }
    
    func fetchedDataSuccessFilter(_ model: FilterModel) {
        if let produtcs = model.results {
            view?.productsData = produtcs
        }
        view?.reloadData()
    }
/*
    func fetchedDataSuccessAddProduct(list: [String]) {
        self.delegate?.valueEntered(data: list)
        guard let vc = view as? UIViewController else { return }
//        router?.goToOrders(vc)
//        vc.navigationController?.popViewController(animated: true)
    }
*/
    func fetchedDataSuccessRemoveAll(_ msg: String) {
        AlertHandler.showAlert(title: "Mensaje:", msg: msg)
    }
    
    func fetchedDataSuccessAddProduct(_ model: CartModel) {
        view?.bottomConstraint.constant = constantBottomShowCart
        view?.carView.isHidden = false
        view?.labelPreci.text = model.total?.rounded(toPlaces: 2).description
        view?.labelCant.text = model.count?.description
    }
    
    func fetchedDataError(_ error: Error) {
        AlertHandler.showError(error: error)
    }
}
