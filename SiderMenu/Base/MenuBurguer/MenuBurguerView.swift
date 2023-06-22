//
//  MenuBurguerViewController.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 10/05/23.
//

import UIKit
import Foundation

protocol MenuBurguerNavigationProtocol {
    func navigateTo(_ destination: MenuBurguerView.MenuOptions)
}

class MenuBurguerView: UIView {

    @IBOutlet weak var backGround: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var content: UIView!
    
    var delegate: MenuBurguerNavigationProtocol?
    
    enum MenuOptions: String, CaseIterable{
        case home = "Home"
        case info = "Information"
        case appRating = "App Rating"
        case shareApp = "Share App"
        case settings = "Settings"
        case logout = "Logout"
        
        var imageName: String {
            switch self {
            case .home:
                return "house"
            case .info:
                return "airplane"
            case .appRating:
                return "star"
            case .shareApp:
                return "message"
            case .settings:
                return "gear"
            case .logout:
                return "arrowshape.turn.up.backward.badge.clock"
            }
        }
    }
    
    let gearColor = UIColor(red: 30/255.0, green: 33/255.0, blue: 211/255.0, alpha: 1)
    
    public static var nibName: String {
        return String(describing: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        load()
//        subviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        load()
//        subviews()
    }
    
    public static var nib: UINib {
            let bundle = Bundle(for: Self.self)
            return UINib(nibName: Self.nibName, bundle: bundle)
        }
    
    func load() {
        let viewName = "MenuBurguerView"
        guard let view = Bundle.main.loadNibNamed(viewName, owner: self, options: nil)?.first as? UIView else { return }
        addSubview(view)
        content.frame = bounds
        content.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = gearColor
    }
    
//    func subviews() {
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
//            self.tableView.frame = CGRect(x: 0, y: (self.safeAreaInsets.top), width: (self.bounds.width), height: (self.bounds.height))
//        }
//    }
    
}

extension MenuBurguerView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.imageView?.image = UIImage(systemName: MenuOptions.allCases[indexPath.row].imageName)
        cell.imageView?.tintColor = UIColor.white
        cell.textLabel?.text = MenuOptions.allCases[indexPath.row].rawValue
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = gearColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = MenuOptions.allCases[indexPath.row]
        delegate?.navigateTo(item)
    }
    
    
}
