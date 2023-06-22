//
//  DropdownTableViewCell.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 19/05/23.
//

import Foundation
import UIKit

struct comboModel {
    let id: Int
    let code: String
    let description: String
}

class DropdownTableViewCell: UITableViewCell {

    static let reuseIdentifier = "DropdownTableViewCell"
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func set(_ text: String) {
        label.text = text
    }
 
}

protocol DropDownButtonDelegate: AnyObject {
    func didSelect(_ item: comboModel)
}

class DropDownButton: UIView {

    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Select", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1.2
        button.layer.borderColor = UIColor.gray.cgColor
        return button
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 4
        stack.axis = .vertical
        return stack
    }()
     
    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.isHidden = true
        table.layer.borderWidth = 1.2
        table.layer.borderColor = UIColor.gray.cgColor
        table.register(DropdownTableViewCell.self, forCellReuseIdentifier: DropdownTableViewCell.reuseIdentifier)
        return table
    }()
    
    var tableViewHeight: NSLayoutConstraint?
    var dataSource: [comboModel] = [] {
         didSet {
             updateTableDataSource()
         }
     }
    var delegate: DropDownButtonDelegate?
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setup() {
        addSubview(stackView)
        stackView.addArrangedSubview(button)
        stackView.addArrangedSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        button.addTarget(self, action: #selector(buttonTapped), for: .primaryActionTriggered)
        tableViewHeight = tableView.heightAnchor.constraint(equalToConstant: 0)
        tableViewHeight?.isActive = true
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo:topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func buttonTapped() {
        tableView.isHidden.toggle()
    }
    
    func updateTableDataSource() {
        if dataSource.count >= 4 {
            tableViewHeight?.constant = 4 * 40
        } else {
            tableViewHeight?.constant = CGFloat(dataSource.count * 40)
        }
        tableView.reloadData()
    }
}

extension DropDownButton: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DropdownTableViewCell.reuseIdentifier, for: indexPath) as? DropdownTableViewCell else { return UITableViewCell() }
        cell.set(dataSource[indexPath.row].description)
        return cell
    }

}

extension DropDownButton: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        button.setTitle(dataSource[indexPath.row].description, for: .normal)
        delegate?.didSelect(dataSource[indexPath.row])
        tableView.isHidden = true
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
