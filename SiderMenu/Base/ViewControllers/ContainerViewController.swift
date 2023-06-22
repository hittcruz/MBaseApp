//
//  ViewController.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 8/05/23.
//

import UIKit

class ContainerViewController: UIViewController {
    
    enum MenuState {
        case opened
        case closed
    }
    
    private var menuState: MenuState = .closed
    
//    let menuVC = MenuViewController()
    let homeVC = HomeViewController()
    var navVC: UINavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
//        addChildVCs()
        
//        UIApplication.shared.windows.first?.rootViewController = NavigationViewController(rootViewController: HomeViewController())
//        UIApplication.shared.windows.first?.makeKeyAndVisible()
//        let navc = NavigationViewController()
//        navc.setViewControllers([HomeViewController()], animated: true)
    }
    
    private func addChildVCs(){
        //MENU
//        menuVC.delegate = self
//        addChild(menuVC)
//        view.addSubview(menuVC.view)
//        menuVC.didMove(toParent: self)
        
        //HOME
//        homeVC.delegate = self
        let navVC = UINavigationController(rootViewController: homeVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        navVC.navigationBar.backgroundColor = .white
        self.navVC = navVC
        
    }
}

//extension ContainerViewController: HomeViewControllerDelegate {
//    func didTapMenuButton() {
//        toggleMenu(completion: nil)
//    }
//
//    func toggleMenu(completion: (()-> Void)?) {
//        //Animate the menu
//        switch menuState{
//        case .closed:
//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
//                self.navVC?.view.frame.origin.x = self.homeVC.view.frame.size.width - 150
//            }completion: { [weak self] done in
//                if done {
//                    self?.menuState = .opened
//                    self?.homeVC.sideMenuOpen = true
//                }
//            }
//        case .opened:
//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
//                self.navVC?.view.frame.origin.x = 0
//            }completion: { [weak self] done in
//                if done {
//                    self?.menuState = .closed
//                    self?.homeVC.sideMenuOpen = false
//                    DispatchQueue.main.async {
//                        completion?()
//                    }
//                }
//            }
//        }
//    }
//}

//extension ContainerViewController: MenuViewControllerDelegate {
//    func didSelect(menuItem: MenuVController.MenuOptions) {
//        print("did select")
//        toggleMenu { [weak self] in
//            switch menuItem {
//            case .home:
//                self?.addHome()
//            case .info:
//                self?.addInfo()
//            case .appRating:
//                break
//            case .shareApp:
//                break
//            case .settings:
//                break
//            }
//        }
//    }
//    
//    func addInfo(){
//        let vc = InfoViewController()
//        homeVC.addChild(vc)
//        homeVC.view.addSubview(vc.view)
//        vc.view.frame = view.frame
//        vc.didMove(toParent: homeVC)
////        self.navVC?.setViewControllers([vc], animated: true)
//    }
//    
//    func addHome(){
//        let vc = HomeViewController()
//        homeVC.addChild(vc)
//        homeVC.view.addSubview(vc.view)
//        vc.view.frame = view.frame
//        vc.didMove(toParent: homeVC)
//    }
//    
//}
