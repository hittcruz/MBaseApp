//
//  NewOrderViewController.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 16/05/23.
//

import UIKit

class NewOrderViewController: UIViewController {

    @IBOutlet weak var txtDateOrder: UITextField!
    @IBOutlet weak var viewCombo: UIView!
//    @IBOutlet weak var stckViewAddProduct: UIStackView!
    var dropdown = DropDownButton()
    
    var delegateOrder: OrdersViewToPresenterProtocol?
    var modelClient: ClientResponse?
    var modelCombo: comboModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view?.backgroundColor = UIColor(white: 0.3, alpha: 0.8)
        dropdown.delegate = self
        dropdown.button.setTitle("Selecciona un cliente", for: .normal)
        
        view.addSubview(dropdown)
//        viewCombo.addSubview(dropdown)
//        stckViewAddProduct.addArrangedSubview(dropdown)
        dropdown.translatesAutoresizingMaskIntoConstraints = false
        dropdown.dataSource = getClients()
        NSLayoutConstraint.activate([
            dropdown.topAnchor.constraint(equalTo: viewCombo.topAnchor),
            dropdown.leadingAnchor.constraint(equalTo: viewCombo.leadingAnchor),
            dropdown.trailingAnchor.constraint(equalTo: viewCombo.trailingAnchor)
                ])
        
        txtDateOrder.delegate = self
        minDate = Date()
//        txtFilterFrom = txtDateOrder
        txtFilterTo = txtDateOrder
        txtDateOrder.addEndDateTextFieldImage()
    }
    
    private func getClients() -> [comboModel]{
        var data:[Client] = []
        
        if let dataList = modelClient?.clients{
            data = dataList
        }
        
        var comboList = data.map({comboModel(id: $0.id ?? 0, code: $0.dni ?? "", description: $0.name ?? "")})
        return comboList
    }

    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func goAddProduct(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        delegateOrder?.goAddProducts(modelCombo?.id ?? 0)
    }
    
}

extension NewOrderViewController: DropDownButtonDelegate {
    func didSelect(_ item: comboModel) {
        modelCombo = item
    }
}

extension NewOrderViewController: txtDeginEditDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtDateOrder {
            txtDateOrder.endSetFilterReportToolbarDoneButton(textfield: textField)
            txtDateOrder.endDatepicker(textField)
        }
    }
}
