//
//  MenuViewController.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 8/05/23.
//

import UIKit

protocol MenuViewControllerDelegate: AnyObject {
    func didSelect(menuItem: MenuVController.MenuOptions)
}

class MenuVController: UIView {
    
    var delegate: MenuViewControllerDelegate?
    
    enum MenuOptions: String, CaseIterable{
        case home = "Home"
        case info = "Information"
        case appRating = "App Rating"
        case shareApp = "Share App"
        case settings = "Settings"
        
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
            }
        }
    }
    let gearColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.backgroundColor = nil
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        load()
        subviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        load()
        subviews()
    }

    func load() {
//        frame.size.width = frame.origin.x + 250
        addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        backgroundColor = gearColor
        
    }
    
    func subviews() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
            self.tableView.frame = CGRect(x: 0, y: (self.safeAreaInsets.top), width: (self.bounds.width), height: (self.bounds.height))
        }
    }

}

extension MenuVController: UITableViewDelegate, UITableViewDataSource {
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
        print("clic option: \(MenuOptions.allCases[indexPath.row].rawValue)")
        let item = MenuOptions.allCases[indexPath.row]
        delegate?.didSelect(menuItem: item)
    }
    
    
}
