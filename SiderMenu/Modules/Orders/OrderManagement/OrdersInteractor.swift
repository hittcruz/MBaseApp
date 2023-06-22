//
//  OrdersInteractor.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 16/05/23.
//

import Foundation
import RxSwift

class OrdersInteractor: OrdersPresenterToInteractorProtocol {
    var presenter: OrdersInteractorToPresenterProtocol?
    
    private let webService = WebService()
    private let disposeBag = DisposeBag()
    
    func prepareResponseForModel() {

        let data = [
            OrderModel(id: 0, user_id: 1, client_id: 1, numberOrder: "00234", order_date: "01/05/2023", delivery_date: "01/05/2023", amount: 12.0, state: "Creado"),
            OrderModel(id: 0, user_id: 1, client_id: 1, numberOrder: "00235", order_date: "03/05/2023", delivery_date: "03/05/2023", amount: 12.0, state: "Preparado"),
            OrderModel(id: 0, user_id: 1, client_id: 1, numberOrder: "00236", order_date: "11/05/2023", delivery_date: "11/05/2023", amount: 12.0, state: "Preparado")
        ]
        
        presenter?.fetchedDataSuccess(list: data)
    }
    
    func prepareResponseClient() {
        webService.load(modelType: ClientResponse.self, from: .client(serviceType: .list))
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] results in
                results.validate {
                    print("OrdersInteractor - prepareResponseSaveOrder ")
//                    print("Data extraida \(results)")
                    self?.presenter?.fetchedDataSuccessClient(results)
                }
                }, onError: { [weak self] error in
                    print("Data extraida \(error)")
                    self?.presenter?.fetchedDataError()
            }).disposed(by: disposeBag)
    }
    
    func prepareResponseSaveOrder() {
        presenter?.fetchedDataSuccessOrder()
    }
}
