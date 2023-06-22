//
//  OrdersPresenter.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 16/05/23.
//

import Foundation
import UIKit

enum segmentOptions: Int {
    case today = 0
    case custom = 1
    case all = 2
}

enum orderOptions: String, CaseIterable {
    case pending = "Pendientes"
    case cancel = "Cancelados"
    case finished = "Finalizados"
}

class OrdersPresenter: NSObject, OrdersViewToPresenterProtocol {
    
    var view: OrdersPresenterToViewProtocol?
    var interactor: OrdersPresenterToInteractorProtocol?
    var router: OrdersPresenterToRouterProtocol?
    
    func updateView() {
        
        //Cargar data
        interactor?.prepareResponseForModel()
        
        //Apariencia
        view?.txtFromDate.delegate = self
        view?.txtToDate.delegate = self
        txtFilterFrom = view?.txtFromDate
        txtFilterTo = view?.txtToDate
        
        initialConfiguration()
    }
    
    func changeLabels(_ item: orderOptions) {
        switch item {
        case .pending:
            view?.lblTitleTable.text = "Lista de Pedidos Pendientes"
            view?.lblTitleTable.textColor = .blue
        case .cancel:
            view?.lblTitleTable.text = "Lista de Pedidos Cancelados"
            view?.lblTitleTable.textColor = .red
        case .finished:
            view?.lblTitleTable.text = "Lista de Pedidos Finalizados"
            view?.lblTitleTable.textColor = .systemGreen
        }
    }
    
    private func initialConfiguration(){
        view?.viewPendingContainer.shadows(opacity: 0.5)
        view?.viewCancelContainer.shadows(opacity: 0.5)
        view?.viewFinishedContainer.shadows(opacity: 0.5)
        
//        view?.txtFromDate.addStartDateTextFieldImage()
//        view?.txtToDate.addEndDateTextFieldImage()
        view?.viewDateFilter.isHidden = true
        view?.lblTitleTable.textColor = .blue
        
        view?.lblTitleTable.text = "Lista de Pedidos Pendientes"
    }
    
    func segmentedAction(_ indicator: Int) {
        
        view?.viewDateFilter.isHidden = indicator == 1 ? false: true
        
        switch segmentOptions(rawValue: indicator){
        case .today:
            print("aqui 0")
        case .custom:
            print("aqui 1")
            view?.txtFromDate.addStartDateTextFieldImage()
            view?.txtToDate.addEndDateTextFieldImage()
        case .all:
            print("aqui 2")
        case .none:
            print("aqui none")
        }
    }
    
    func goAddProducts(_ index: Int) {
        print("save Order index \(index)")
        interactor?.prepareResponseSaveOrder()
    }
    
    func goNewOrder() {
        interactor?.prepareResponseClient()
    }
}

extension OrdersPresenter: OrdersInteractorToPresenterProtocol{
    func fetchedDataSuccessClient(_ model: ClientResponse) {
        guard let vc = view as? UIViewController else {return}
        let viewController = NewOrderViewController()
//        let viewController = testViewController()
        viewController.delegateOrder = self
        viewController.modelClient = model
        viewController.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        viewController.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        vc.present(viewController, animated: true, completion: nil)
    }
    
    func fetchedDataSuccess(list: [OrderModel]) {
        view?.reloadTable(data: list)
        print("charge data OrderModel")
    }
    
    func fetchedDataSuccessOrder() {
        guard let vc = view as? UIViewController else {return}
        print("go add product")
        router?.goToAddProducts(vc, self)
    }
    
    func fetchedDataError() {
        
    }
}

extension OrdersPresenter: delegateOrderAddProductProtocol {
    func valueEntered(data: [String]) {
        print("datos desde ORdersPresenter: \(data) para actualizar la data")
    }
    
    
}

extension OrdersPresenter: txtDeginEditDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == view?.txtFromDate {
            view?.txtFromDate.startSetFilterReportToolbarDoneButton(textfield: textField)
            view?.txtFromDate.startDatepicker(textField)
        } else if textField == view?.txtToDate {
            view?.txtToDate.endSetFilterReportToolbarDoneButton(textfield: textField)
            view?.txtToDate.endDatepicker(textField)
        }
    }
}
