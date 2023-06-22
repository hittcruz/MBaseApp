//
//  NavigationViewController.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 9/05/23.
//

import UIKit



enum NavigationLeftPrivate {
    case menu, none
}

enum NavigationRightPrivate {
    case none
}

enum NavigationMiddlePrivate {
    case imageTitle(image: String, text: String)
    case title(text: String)
    case leftTitle(text: String)
}

class NavigationViewController: UINavigationController {
    
    enum MenuState {
        case opened
        case closed
    }
    
    fileprivate lazy var menuVC: MenuBurguerView = {
        let menu = MenuBurguerView(frame: self.view.frame)
        menu.backGround.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(NavigationViewController.didTapMenuButton)))
        return menu
    }()
    
    private var menuState: MenuState = .closed
    
    fileprivate var target: UIViewController!

    fileprivate lazy var hamburgerButton: UIBarButtonItem = {
        let image = UIImage(systemName: "list.dash")
        let burguerButton = UIBarButtonItem(image: image, style: UIBarButtonItem.Style.plain, target: self, action: #selector(didTapMenuButton))
        burguerButton.tintColor = UIColor.red
        return burguerButton
    }()
    
    override public var viewControllers: [UIViewController] {
        didSet {
            guard let vc = viewControllers.last else { return }
            configureTarget(vc)
        }
    }
    
    override public func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        super.setViewControllers(viewControllers, animated: animated)
        configureTarget(viewControllers[0])
    }
    
    override public func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        configureTarget(viewController)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
//        configureBadges()
//        }
         
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func didTapMenuButton(){
        toggleMenu(completion: nil)
    }
    
    func toggleMenu(completion: (()-> Void)?) {
        //Animate the menu
        switch menuState{
        case .closed:
            self.view.endEditing(true)
            self.view.addSubview(menuVC)
            menuVC.delegate = self
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.menuVC.frame.size.width = self.target.view.frame.size.width
            }completion: { [weak self] done in
                if done {
                    self?.menuState = .opened
                }
            }
        case .opened:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.menuVC.frame.size.width = 0
            }completion: { [weak self] done in
                if done {
                    self?.menuState = .closed
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
            }
        }
    }
    
    func configureTarget(_ target: UIViewController) {
        self.target = target
        switch target {
        case is HomeViewController:
            configure(left: .menu, middle: .title(text: "home View"), backgroundColor: .systemFill)
        case is InfoViewController:
            configure(left: .menu, middle: .title(text: "Info View"), backgroundColor: UIColor.systemFill)
        case is OrdersViewController:
            configure(left: .menu, middle: .title(text: "Orders View"))
        case is OrderAddProductViewController:
            configure(left: .menu, middle: .title(text: "Add Product"), backgroundColor: .systemFill)
        default:
            break
        }
    }
    
    func configure(left: NavigationLeftPrivate? = nil, middle: NavigationMiddlePrivate? = nil, right: NavigationRightPrivate? = nil, backgroundColor: UIColor? = nil){
        if let left = left {
            target.navigationItem.leftBarButtonItem = setupLeftBarButton(type: left)
        }

        if let middle = middle {
            setupMiddleButton(type: middle)
        }

        if let right = right {
            print(" right \(right)")
            //setupRightBarButton(type: right)
        }

        if let backgroundColor = backgroundColor {
            target.navigationController?.navigationBar.backgroundColor = backgroundColor
        } else {
            target.navigationController?.navigationBar.backgroundColor = .systemFill
        }
    }

}

extension NavigationViewController {
    fileprivate func setupLeftBarButton(type: NavigationLeftPrivate?) -> UIBarButtonItem? {
        guard let type = type else { return nil }
        switch type {
        case .menu:
            return hamburgerButton
        case .none:
            return nil
        }
    }
    
    fileprivate func setupMiddleButton(type: NavigationMiddlePrivate?) {
        guard let type = type else { return }
        switch type {
        case .imageTitle(let image, let text):
            target.navigationItem.titleView = navTitleWithImageAndText(titleText: text, imageName: image)
//            target.navigationItem.title = text
        case .title(let text):
            target.navigationItem.titleView = navTitleWithImageAndText(titleText: text, imageName: nil)
//            target.navigationItem.title = text
        case .leftTitle(text: let text):
                let leftInsect = 30
                let leftLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - CGFloat(leftInsect), height: view.frame.height))
                leftLabel.text = text
            target.navigationItem.titleView = leftLabel
        }
    }
    
    func navTitleWithImageAndText(titleText: String, imageName: String?) -> UIView {
        let titleView = UIView()
        let label = UILabel()
        label.text = titleText
        label.textColor = UIColor.black
        label.sizeToFit()
        label.center = titleView.center
        label.textAlignment = NSTextAlignment.center
        
            if imageName != nil, !(imageName!.isEmpty) {
                let image = UIImageView()
                image.image =  UIImage(named: imageName!, in: nil, compatibleWith: nil)//UIImage(named: imageName)
                
                let imageAspect = image.image!.size.width / image.image!.size.height
                let imageX = label.frame.origin.x - label.frame.size.height * imageAspect
                let imageY = label.frame.origin.y
                let imageWidth = label.frame.size.height * imageAspect
                let imageHeight = label.frame.size.height
                image.frame = CGRect(x: imageX - 1.5, y: imageY, width: imageWidth, height: imageHeight)
                image.contentMode = UIView.ContentMode.scaleAspectFit
                titleView.addSubview(image)
            }
        
        titleView.addSubview(label)
        titleView.sizeToFit()
        return titleView
    }
}

extension NavigationViewController: MenuBurguerNavigationProtocol {
    func navigateTo(_ destination: MenuBurguerView.MenuOptions) {
        didTapMenuButton()
        print("navegando a \(destination)")
        switch destination {
        case .home:
            goHome()
        case .info:
            gotInfo()
        case .appRating:
            break
        case .shareApp:
            break
        case .settings:
            break
        case .logout:
            goLogout()
        }
    }
    
    private func gotInfo(){
        setViewControllers([InfoViewController()], animated: true)
    }
    
    private func goHome(){
        setViewControllers([HomeViewController()], animated: true)
    }
    
    private func goLogout(){
        let newroot = LoginViewController()
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            self.setViewControllers([newroot], animated: false)
        })
        self.popToRootViewController(animated: true)
        CATransaction.commit()

        RemoteLib.shared.setSaveCredentialLogin(saveCredentiales: false)
    }
}
