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
    
    func prepareResponseAddProduct() {
        let datos = ["galon de agua", "gas"]
        presenter?.fetchedDataSuccessAddProduct(list: datos)
    }
}
