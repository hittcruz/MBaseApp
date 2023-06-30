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
    case create = "CR"
    case cancel = "CN"
    case pending = "PR"
    case finished = "FN"
    
    func getTitle()-> String{
        switch self {
        case .create:
            return "Creados "
        case .cancel:
            return "Cancelados "
        case .pending:
            return "Pendientes "
        case .finished:
            return "Finalizados "
        }
    }
}

class OrdersPresenter: NSObject, OrdersViewToPresenterProtocol {
    
    var view: OrdersPresenterToViewProtocol?
    var interactor: OrdersPresenterToInteractorProtocol?
    var router: OrdersPresenterToRouterProtocol?
    var dataStatus: [StatusModel] = []
    var statusID: Int = -1
    var title: String = "Lista de Pedidos "
    
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
    
    func changeLabels(_ code: String) {
        let cod = dataStatus.filter({$0.code == code}).first
        statusID = cod?.stateID ?? -1
        let type = orderOptions(rawValue: code)?.getTitle() ?? ""
        title = "Lisa de Pedidos \(type)"
        view?.filterSegmentControl.selectedSegmentIndex = 2
        interactor?.prepareResponseFilterStatus(statusID, "", "")
    }
    
    private func initialConfiguration(){
        view?.viewPendingContainer.shadows(opacity: 0.5)
        view?.viewCancelContainer.shadows(opacity: 0.5)
        view?.viewFinishedContainer.shadows(opacity: 0.5)
        view?.viewCreateContainer.shadows(opacity: 0.5)
        
//        view?.txtFromDate.addStartDateTextFieldImage()
//        view?.txtToDate.addEndDateTextFieldImage()
        view?.viewDateFilter.isHidden = true
        view?.lblTitleTable.textColor = .blue
        view?.filterSegmentControl.selectedSegmentIndex = 2
        view?.lblTitleTable.text = title
    }
    
    func segmentedAction(_ indicator: Int) {
        
        view?.viewDateFilter.isHidden = indicator == 1 ? false: true
        
        switch segmentOptions(rawValue: indicator){
        case .today:
            let today = DateUtils.getStringDateFrom("YYYY-MM-dd", Date())
            interactor?.prepareResponseFilterStatus(statusID , today, today)
        case .custom:
            view?.txtFromDate.addStartDateTextFieldImage()
            view?.txtToDate.addEndDateTextFieldImage()
        case .all:
            interactor?.prepareResponseFilterStatus(statusID , "", "")
        case .none:
            break
        }
    }
    
    func goAddProducts(_ index: Int,_ deliveryDate: String){
        let userId = 1
        let clientId = index
        let dateOrder = DateUtils.getStringDateFrom("YYYY-MM-dd", Date())
        let deliveryOrder = deliveryDate
        let statusId = 1
        interactor?.prepareResponseSaveOrder(userID: userId, clientID: clientId, orderDate: dateOrder, deliveryDate: deliveryOrder, statusID: statusId)
    }
    
    func goNewOrder() {
        interactor?.prepareResponseClient()
    }
    
    func filterAction() {
        
        if let fromDate = minDate, let toDate = maxDate {
            interactor?.prepareResponseFilterStatus(statusID , DateUtils.getStringDateFrom("YYYY-MM-dd", fromDate), DateUtils.getStringDateFrom("YYYY-MM-dd", toDate))
        }else{
            AlertHandler.showAlert(title: "Fecha vacía", msg: "Selecciona fecha de inicio y fin")
        }
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
    
    func fetchedDataSuccess(_ model: OrdersResponse) {
        let data = model.orders
        dataStatus = model.status
        view?.lblTitleTable.text = title + data.count.description + "/" + data.count.description
        view?.reloadTable(data: data)
    }
    
    func fetchedDataSuccessOrder(_ model: OrdersResponse) {
        guard let vc = view as? UIViewController else {return}
        print("go add product - \(model)")
        router?.goToAddProducts(vc, self, model)
    }
    
    func fetchedDataSuccessFilterStatus(_ model: OrdersResponse) {
        let data = model.orders
//        dataStatus = model.status
        view?.lblTitleTable.text = title + data.count.description + "/" + data.count.description
        view?.reloadTable(data: data)
    }
    
    func fetchedDataError(_ error: Error) {
        AlertHandler.showError(error: error)
    }
    
    private func updateFilterData(_ model: OrdersResponse){
        
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
