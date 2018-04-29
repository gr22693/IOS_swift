//
//  ViewController.swift
//  ShoppingCart
//
//  Created by gowthamraj on 22/03/18.
//  Copyright © 2018 gowthamraj. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
   
    let log_api : String = "http://13.229.125.8:8081/api/login"
    
    //Outlets
    @IBOutlet weak var usernametextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var login_icon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     self.usernametextField.delegate = self
      self.passwordTextField.delegate = self
       self.login_icon.layer.cornerRadius = self.login_icon.frame.size.width / 2
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func loginTapped(_ sender: Any) {
    
        if usernametextField.text != "" ,  (usernametextField.text?.isValidEmail)!{
      
           if passwordTextField.text != "",  (passwordTextField.text?.isValidPassword)! {
         
              self.requestApi()
            usernametextField.text = ""
            passwordTextField.text = ""
            
//           let homeVc = self.storyboard?.instantiateViewController(withIdentifier: "HomeScreenViewController") as!HomeScreenViewController
//                self.navigationController?.present(homeVc, animated: true, completion: nil)

            
           }else{
            self.invalidPassword()
            passwordTextField.text = ""
            }
        }else{
            self.invalidUserName()
            usernametextField.text = ""
            passwordTextField.text = ""
        }
            
//            else{
//            print("enter valid details")
//            self.invalidLogin()
//            usernametextField.text = ""
//            passwordTextField.text = ""
//            }
        
    }//End of loginTapped IB action
    
    @IBAction func forgotPassWordTapped(_ sender: Any) {
    
        let alertController = UIAlertController(title: "Hi", message: "Please enter your e-Mail ID", preferredStyle: .alert)
        alertController.addTextField { (textField1) in
            textField1.placeholder = "e-Mail"
        }
        let okaction = UIAlertAction(title: "OK", style: .default) { (uiAlertAction) in
            guard let eMailtextField = alertController.textFields?[0] else {return}
            if let eMail = eMailtextField.text, eMail != ""{
                //self.toFetchTheEmail()
                
                let alertController = UIAlertController(title: "Email sent", message: "An e-Mail sent to your mentioned mailID, Please check", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                
                
            }
        }
        alertController.addAction(okaction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
}
//MARK:- Api Functions
extension LoginViewController {
    
    func requestApi()  {
       
        guard let email = self.usernametextField.text, let password = self.passwordTextField.text
            else {
            return
        }
        
        let postvalue = ["email" : email, "password" : password]
        
        if let jsondata = try? JSONSerialization.data(withJSONObject: postvalue, options: []) {
            
    
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        if let url = URL(string: self.log_api){
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            
            //urlRequest.addValue("application/JSON", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = jsondata
            
             let datatask = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                if error == nil{
                    if let statuscode = (response as? HTTPURLResponse)?.statusCode{
                        if statuscode == 200 {
                            print("API call sucessfull")
                           self.serialization(withdata: data)
                        }
                    }
                }else {
                    print("error in API Call")
                }
                
            })
            datatask.resume()
        }
        
    }
}
    
    
    func serialization(withdata data : Data?){
        guard let responsedata = data else{return}
        do{
            if let jsondata = try JSONSerialization.jsonObject(with: responsedata, options: .mutableContainers) as? NSDictionary{
            print(jsondata)
            }
        }catch let error{
            print("error on serialization:\(error.localizedDescription)")
        }
        
        
    }
   
    
}


//MARK:-UITextFieldDelegate
extension LoginViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//MARK:- UIALERTACTIONS

extension LoginViewController{
    func invalidLogin()  {
        let alertController = UIAlertController(title: "Invalid Login", message: "Enter Valid Credentials.\n If you don't have account Click Create New User to register", preferredStyle: .alert)
        let okaction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okaction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func  invalidUserName()  {
        let alertController = UIAlertController(title: "Invalid UserName", message: "Enter Valid UserName...\n If you don't have account Click Create New User to register", preferredStyle: .alert)
        let okaction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okaction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func  invalidPassword()  {
        let alertController = UIAlertController(title: "Invalid UserName", message: "Please enter valid password...",
                                                preferredStyle: .alert)
        let okaction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okaction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}


