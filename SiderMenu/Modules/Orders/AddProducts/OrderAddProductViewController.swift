//
//  OrderAddProductViewController.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 15/05/23.
//

import UIKit

class OrderAddProductViewController: UIViewController {
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var secondaryView: UIView!
    
    @IBOutlet weak var cvAlls: UICollectionView!{
        didSet{
            let requestCell = UINib(nibName: AllsProductsCollectionViewCell.cellType, bundle: nil)
            cvAlls.register(requestCell, forCellWithReuseIdentifier: AllsProductsCollectionViewCell.cellType)
        }
    }
    @IBOutlet weak var cvPopulars: UICollectionView!{
        didSet{
            let requestCell = UINib(nibName: PopularsCollectionViewCell.cellType, bundle: nil)
            cvPopulars.register(requestCell, forCellWithReuseIdentifier: PopularsCollectionViewCell.cellType)
        }
    }
    @IBOutlet weak var cvCategories: UICollectionView!{
        didSet{
            let requestsCell = UINib(nibName: CategoriesCollectionViewCell.cellType, bundle: nil)
            cvCategories.register(requestsCell, forCellWithReuseIdentifier: CategoriesCollectionViewCell.cellType)
        }
    }
    
    private let carView: UIView = {
        let car = UIView()
        car.translatesAutoresizingMaskIntoConstraints = false
        car.layer.cornerRadius = 8
        car.backgroundColor = .systemGreen
        return car
    }()
    
    var presenter: OrderAddProductViewToPresenterProtocol?
    
    var productsData: [Products] = []
    var categoriesData: [Category] = []
    var popularsData: [Products] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.updateView()
        
        cvCategories.delegate = self
        cvCategories.dataSource = self
        
        cvPopulars.delegate = self
        cvPopulars.dataSource = self
        
        cvAlls.delegate = self
        cvAlls.dataSource = self
     
    }

    @IBAction func backAction(_ sender: Any) {
        let datos = ["galon de agua", "gas"]
//        presenter?.saveProduct(datos)
    }
    
    private func createCarView(_ model: CartModel){
        let cantView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .white
            view.layer.cornerRadius = 20
            return view
        }()
        
        let labelCant: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = String(model.count)
            label.textColor = .black
            label.font = UIFont.boldSystemFont(ofSize: 20)
            return label
        }()
        
        let labelTitle: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Productos"
            label.textColor = .white
            label.font = UIFont.boldSystemFont(ofSize: 18)
            return label
        }()
        
        let labelSymbol: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "S/."
            label.textColor = .systemGray
            label.font = UIFont.boldSystemFont(ofSize: 15)
            return label
        }()
        
        let labelPreci: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = String(model.count)
            label.textColor = .systemGray
            label.font = UIFont.boldSystemFont(ofSize: 15)
            return label
        }()
        
        let showButton: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.layer.cornerRadius = 8
            button.layer.masksToBounds = true
            button.setTitle("Mostrar", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.addTarget(self, action: #selector(showCartView(_:)), for: .touchUpInside)
            button.backgroundColor = .systemBlue
            
            return button
        }()
        
        let clearButton: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.layer.cornerRadius = 8
            button.layer.masksToBounds = true
            button.setTitle("Limpiar", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.addTarget(self, action: #selector(clearCart(_:)), for: .touchUpInside)
            button.backgroundColor = .systemBlue
            
            return button
        }()
        
        cantView.addSubview(labelCant)
        carView.addSubview(labelTitle)
        carView.addSubview(labelSymbol)
        carView.addSubview(labelPreci)
        carView.addSubview(cantView)
        carView.addSubview(showButton)
        carView.addSubview(clearButton)
        
        carView.leadingAnchor.constraint(equalTo: secondaryView.leadingAnchor, constant: 15).isActive = true
        carView.trailingAnchor.constraint(equalTo: secondaryView.trailingAnchor, constant: -15).isActive = true
        carView.bottomAnchor.constraint(equalTo: secondaryView.bottomAnchor, constant: 5).isActive = true
        carView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        cantView.centerYAnchor.constraint(equalTo: carView.centerYAnchor).isActive = true
        cantView.leadingAnchor.constraint(equalTo: carView.leadingAnchor, constant: 5).isActive = true
        cantView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        cantView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        labelCant.centerYAnchor.constraint(equalTo: cantView.centerYAnchor).isActive = true
        labelCant.centerXAnchor.constraint(equalTo: cantView.centerXAnchor).isActive = true
        
        labelTitle.topAnchor.constraint(equalTo: carView.topAnchor, constant: 5).isActive = true
        labelTitle.leadingAnchor.constraint(equalTo: cantView.trailingAnchor, constant: 15).isActive = true
        
        labelSymbol.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 5).isActive = true
        labelSymbol.leadingAnchor.constraint(equalTo: cantView.trailingAnchor, constant: 15).isActive = true
        labelSymbol.bottomAnchor.constraint(equalTo: carView.bottomAnchor, constant: -5).isActive = true
        
        labelPreci.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 5).isActive = true
        labelPreci.leadingAnchor.constraint(equalTo: labelSymbol.trailingAnchor, constant: 5).isActive = true
        labelPreci.bottomAnchor.constraint(equalTo: carView.bottomAnchor, constant: -5).isActive = true
        
        showButton.centerYAnchor.constraint(equalTo: carView.centerYAnchor).isActive = true
        showButton.leadingAnchor.constraint(equalTo: labelTitle.trailingAnchor, constant: 5).isActive = true
        showButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        clearButton.centerYAnchor.constraint(equalTo: carView.centerYAnchor).isActive = true
        clearButton.leadingAnchor.constraint(equalTo: showButton.trailingAnchor, constant: 5).isActive = true
        clearButton.trailingAnchor.constraint(equalTo: carView.trailingAnchor, constant: -5).isActive = true
        clearButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
    }
    
    @objc func showCartView(_ sender: UIButton) {
        print("show cart")
        sender.handleTap()
    }
    
    @objc func clearCart(_ sender: UIButton) {
        print("clear cart")
        sender.handleTap()
        carView.removeFromSuperview()
        bottomConstraint.constant = 8
    }
}

extension OrderAddProductViewController: OrderAddProductPresenterToViewProtocol {
    func reloadData() {
        cvPopulars.reloadData()
        cvCategories.reloadData()
        cvAlls.reloadData()
    }
  
    func createCart(_ model: CartModel) {
        view.addSubview(carView)
        createCarView(model)
    }
}

extension OrderAddProductViewController: delegateTapProducts {
    func tapAddProduct(index: Int) {
        presenter?.addProduct(index)
    }
}

extension OrderAddProductViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.cvCategories {
//            return CategorieOption.allCases.count
            return categoriesData.count
        }else if collectionView == self.cvPopulars{
            return popularsData.count
        }else{
            return productsData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.cvCategories {
            let cellReuseIdentifier = "CategoriesCollectionViewCell"
            collectionView.register(UINib(nibName: "CategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellReuseIdentifier)
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier , for: indexPath) as! CategoriesCollectionViewCell
            cell.displayCategories(item: categoriesData[indexPath.row])
            return cell
            
        } else if collectionView == self.cvPopulars {
            let cellReuseIdentifier = "PopularsCollectionViewCell"
            collectionView.register(UINib(nibName: "PopularsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellReuseIdentifier)
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier , for: indexPath) as! PopularsCollectionViewCell
            cell.viewAddProduct.tag = indexPath.row
            cell.displayPopulars(item: popularsData[indexPath.row])
            return cell
        }else{
            let cellReuseIdentifier = "AllsProductsCollectionViewCell"
            collectionView.register(UINib(nibName: "AllsProductsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellReuseIdentifier)
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier , for: indexPath) as! AllsProductsCollectionViewCell
            cell.viewAddProduct.tag = indexPath.row
            cell.delegate = self
            cell.displayProducts(item: productsData[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        if collectionView == self.cvCategories {
            guard let c = collectionView.cellForItem(at: indexPath) as? CategoriesCollectionViewCell else { return }
//            c.containerView.backgroundColor = categoriesData[indexPath.row].active ? .clear : .systemGreen
//            categoriesData[indexPath.row].active = categoriesData[indexPath.row].active ? false : true
        }
    }
    
}

extension OrderAddProductViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.cvCategories {
            return getWithdHeight(100, 100, collectionView)
        }else if collectionView == self.cvPopulars{
            return CGSize(width: 200, height: 140)
        }else{
            return CGSize(width: 150, height: 200)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)}
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {return 0}
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {return 0}
    
    private func getWithdHeight(_ with: Double,_ height: Double, _ collectionView: UICollectionView) -> CGSize{
        let minimalWidth:CGFloat = with
        let contentViewWidth = collectionView.frame.size.width
        let itemsPerRow = Int(contentViewWidth / minimalWidth)
        let newWidth = contentViewWidth / CGFloat(itemsPerRow)
        let width = max(minimalWidth, newWidth)
        return CGSize(width: width, height: height)
    }
}
