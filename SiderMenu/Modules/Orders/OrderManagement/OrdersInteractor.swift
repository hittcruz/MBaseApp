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
        webService.load(modelType: OrdersResponse.self, from: .order(serviceType: .list))
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] results in
                results.validate {
                    self?.presenter?.fetchedDataSuccess(results)
                }
                }, onError: { [weak self] error in
                    self?.presenter?.fetchedDataError(error)
            }).disposed(by: disposeBag)
    }
    
    func prepareResponseClient() {
        webService.load(modelType: ClientResponse.self, from: .client(serviceType: .list))
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] results in
                results.validate {
//                    print("Data extraida \(results)")
                    self?.presenter?.fetchedDataSuccessClient(results)
                }
                }, onError: { [weak self] error in
                    self?.presenter?.fetchedDataError(error)
            }).disposed(by: disposeBag)
    }
    
    func prepareResponseFilterStatus(_ statusId: Int, _ fromDate: String,_ toDate:String) {
        webService.load(modelType: OrdersResponse.self, from: .order(serviceType: .filterOrder(statusID: statusId, fromDate: fromDate, toDate: toDate)))
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] results in
                results.validate {
                    self?.presenter?.fetchedDataSuccessFilterStatus(results)
                }
            }, onError: {[weak self] error in
                self?.presenter?.fetchedDataError(error)
            }).disposed(by: disposeBag)
    }
    
    func prepareResponseSaveOrder(userID: Int, clientID: Int, orderDate: String, deliveryDate: String, statusID: Int) {
        webService.load(modelType: OrdersResponse.self, from: .order(serviceType: .createOrder(userID: userID, clientID: clientID, orderDate: orderDate, deliveryDate: deliveryDate, statusID: statusID)))
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] results in
                results.validate {
                    self?.presenter?.fetchedDataSuccessOrder(results)
                }
            }, onError: {[weak self] error in
                self?.presenter?.fetchedDataError(error)
            }).disposed(by: disposeBag)
    }
}
