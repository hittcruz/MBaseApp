//
//  OrdersRouter.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 16/05/23.
//

import Foundation
import UIKit

class OrdersRouter : OrdersPresenterToRouterProtocol {
    
    
    static func createModule() -> UIViewController {
        let view = OrdersViewController()
        let presenter : OrdersViewToPresenterProtocol & OrdersInteractorToPresenterProtocol = OrdersPresenter()
        let interactor : OrdersPresenterToInteractorProtocol = OrdersInteractor()
        let router: OrdersPresenterToRouterProtocol = OrdersRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
      
        return view
    }
    
    func goToAddProducts(_ origin: UIViewController?,_ delegate: delegateOrderAddProductProtocol, _ model: OrderModel) {
        let navigationController = origin?.navigationController as? NavigationViewController
        if let navigationController = navigationController {
//            navigationController.pushViewController(OrderAddProductRouter.createModule(delegate), animated: true)
            navigationController.setViewControllers([OrderAddProductRouter.createModule(model)], animated: true)
        } else {
            origin?.navigationController?.setViewControllers([OrderAddProductRouter.createModule(delegate)], animated: true)
        }
    }
}
