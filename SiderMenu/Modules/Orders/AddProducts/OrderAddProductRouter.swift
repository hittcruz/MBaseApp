//
//  OrderAddProductRouter.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 16/05/23.
//

import Foundation
import UIKit

class OrderAddProductRouter : OrderAddProductPresenterToRouterProtocol {
    
    static func createModule(_ delegate: delegateOrderAddProductProtocol) -> UIViewController {
        let view = OrderAddProductViewController()
        let presenter : OrderAddProductViewToPresenterProtocol & OrderAddProductInteractorToPresenterProtocol = OrderAddProductPresenter(delegate: delegate)
        let interactor : OrderAddProductPresenterToInteractorProtocol = OrderAddProductInteractor()
        let router: OrderAddProductPresenterToRouterProtocol = OrderAddProductRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
      
        return view
    }
    
    static func createModule() -> UIViewController {
        let view = OrderAddProductViewController()
        let presenter : OrderAddProductViewToPresenterProtocol & OrderAddProductInteractorToPresenterProtocol = OrderAddProductPresenter()
        let interactor : OrderAddProductPresenterToInteractorProtocol = OrderAddProductInteractor()
        let router: OrderAddProductPresenterToRouterProtocol = OrderAddProductRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
      
        return view
    }
    
    func goToOrders(_ origin: UIViewController?) {
        let navigationController = origin?.navigationController as? NavigationViewController
        if let navigationController = navigationController {
            navigationController.setViewControllers([OrdersRouter.createModule()], animated: true)
        } else {
            origin?.navigationController?.setViewControllers([OrdersRouter.createModule()], animated: true)
        }
    }
}
