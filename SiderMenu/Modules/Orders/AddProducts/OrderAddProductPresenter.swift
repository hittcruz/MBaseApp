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
        interactor?.prepareResponseCategory()
        interactor?.prepareResponseForModel()
        initialConfiguration()
    }
    
    private func initialConfiguration(){
        view?.bottomConstraint.constant = constantBottomCloseCart
    }
    
    func addProduct(_ index: Int) {
        view?.bottomConstraint.constant = constantBottomShowCart
        let item = view?.productsData[index]
//        view?.createCart(<#T##model: CartModel##CartModel#>)
        print("OrderAddProductPresenter-delegateTapProducts \(view?.productsData[index].name)")
        interactor?.prepareResponseAddProduct()
    }
    
    func saveProduct(_ list: [String]) {
        
       // self.delegate?.valueEntered(data: list)
        
//        guard let vc = view as? UIViewController else { return }
//        vc.navigationController?.popViewController(animated: true)
//        vc.navigationController?.popToViewController(OrdersRouter.createModule(), animated: true)
        
//        interactor?.prepareResponseAddProduct()
    }
    
}

extension OrderAddProductPresenter: OrderAddProductInteractorToPresenterProtocol {
    func fetchedDataSuccessCategory(_ model: CategorieResponse) {
        if let categories = model.categories {
            view?.categoriesData = categories.sorted { $0.description ?? "" < $1.description ?? ""}
        }
    }
    
    func fetchedDataSuccess(model: ProductResponse) {
        if let populars = model.populars {
            view?.popularsData = populars
        }
        
        if let produtcs = model.products {
            view?.productsData = produtcs
        }
        view?.reloadData()
    }

    func fetchedDataSuccessAddProduct(list: [String]) {
        self.delegate?.valueEntered(data: list)
        guard let vc = view as? UIViewController else { return }
//        router?.goToOrders(vc)
//        vc.navigationController?.popViewController(animated: true)
    }
    
    func fetchedDataError() {
        
    }
}
