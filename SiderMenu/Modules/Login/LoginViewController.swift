//
//  LoginViewController.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 11/05/23.
//

import UIKit


class LoginViewController: UIViewController {

    @IBOutlet weak var checkBox: CheckBox!
    @IBOutlet weak var textUser: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    
    var username: String = ""
    var password: String = ""
    
    var check: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadCredentials()
        
        navigationController?.isNavigationBarHidden = true
    }
    
    private func loadCredentials(){
        let credentials =  RemoteLib.shared.settingsManager.saveCredentiales
        print("credentials: \(credentials)")
        if credentials {
            goHome()
        }
    }
    
    private func saveCredentials(){
        RemoteLib.shared.setSaveCredentialLogin(username: username, password: password, saveCredentiales: check)
    }

    @IBAction func checkBoxAction(_ sender: Any) {
        check = check ? false : true
        print("check: \(check)")
    }
    
    @IBAction func login(_ sender: Any) {
        username = textUser.text ?? ""
        password = textPassword.text ?? ""
        
        if !username.isEmpty && !password.isEmpty {
            if username == "hitt" && password == "1234" {
                //ingresa al system
                saveCredentials()
                goHome()
                
            }else{
                print("User o pass son incorrectos")
            }
        } else{
          print("el user o pass estan vacios")
        }
    }
    
    func goHome(){
        let initialView =  HomeViewController()
        let navigationBarPrivate = NavigationViewController(rootViewController: initialView)
        UIApplication.shared.windows.first?.rootViewController = navigationBarPrivate
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}
