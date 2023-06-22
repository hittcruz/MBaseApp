//
//  OrderAddProductInteractor.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 16/05/23.
//

import Foundation
import RxSwift

class OrderAddProductInteractor: OrderAddProductPresenterToInteractorProtocol {
    var presenter: OrderAddProductInteractorToPresenterProtocol?
    private let webService = WebService()
    private let disposeBag = DisposeBag()
    
    func prepareResponseCategory() {
        webService.load(modelType: CategorieResponse.self, from: .category(serviceType: .list))
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] results in
                results.validate {
//                    print("Data extraida \(results)")
                    self?.presenter?.fetchedDataSuccessCategory(results)
                }
                }, onError: { [weak self] error in
                    print("Data extraida \(error)")
                    self?.presenter?.fetchedDataError()
            }).disposed(by: disposeBag)
    }
    func prepareResponseForModel() {
        
        webService.load(modelType: ProductResponse.self, from: .product(serviceType: .list))
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] results in
                results.validate {
//                    print("Data extraida \(results)")
                    self?.presenter?.fetchedDataSuccess(model: results)
                }
                }, onError: { [weak self] error in
                    print("Data extraida \(error)")
                    self?.presenter?.fetchedDataError()
            }).disposed(by: disposeBag)
    }
    
    func prepareShowCart(_ orderId: Int) {
        webService.load(modelType: CartModel.self, from: .order(serviceType: .showCart(orderID: orderId)))
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] results in
                results.validate {
                    print("Data extraida \(results)")
                    self?.presenter?.fetchedDataSuccessShowCart(results)
                }
                }, onError: { [weak self] error in
                    print("Data extraida \(error)")
                    self?.presenter?.fetchedDataError()
            }).disposed(by: disposeBag)
    }
    
    func prepareResponseAddProduct(_ orderId: Int, _ productID: Int,_ preci:Double) {
        let quantity = 1
        webService.load(modelType: CartModel.self, from: .order(serviceType: .addProduct(orderID: orderId, productID: productID, quantity: quantity, salePreci: preci)))
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] results in
                results.validate {
                    print("Data extraida \(results)")
                    self?.presenter?.fetchedDataSuccessAddProduct(results)
                }
                }, onError: { [weak self] error in
                    print("Data extraida \(error)")
                    self?.presenter?.fetchedDataError()
            }).disposed(by: disposeBag)
    }
    
    func prepareResponseRemoveAllProduct(_ orderId: Int) {
        webService.load(modelType: CartModel.self, from: .order(serviceType: .removeAllProduct(orderID: orderId)))
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] results in
                results.validate {
                    print("Data extraida \(results)")
                }
                }, onError: { [weak self] error in
                    print("Data extraida \(error)")
                    self?.presenter?.fetchedDataError()
            }).disposed(by: disposeBag)
    }
}
