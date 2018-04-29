//
//  RegistrationViewController.swift
//  ShoppingCart
//
//  Created by gowthamraj on 24/03/18.
//  Copyright © 2018 gowthamraj. All rights reserved.
//

import UIKit
import  CoreData

class RegistrationViewController: UIViewController {
    
    let reg_API = "http://13.229.125.8:8081/api/register"
    
    @IBOutlet weak var firstNameTextfield: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var eMailtextfield: UITextField!
    @IBOutlet weak var mobileNoTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    //var userDetailsArray : [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func registerationTapped(_ sender: Any) {
     
        if let firstnameTextfield = firstNameTextfield.text, let lastNameTextField = lastNameTextField.text, let emailTextField = eMailtextfield.text ,let mobilenofield = mobileNoTextField.text , let passwordField = passwordTextField.text{
           
            if firstnameTextfield != "" &&
                lastNameTextField != "" &&
                mobilenofield != "" &&
                emailTextField != "" && passwordField != "" {
                
                if emailTextField.isValidEmail {
                    
                    if passwordField.isValidPassword {
                    
                        //calling API
                        self.requestApi()
                       
                        //Clearing Textfields once Register button tapped
                        self.firstNameTextfield.text = ""
                        self.lastNameTextField.text = ""
                        self.eMailtextfield.text = ""
                        self.mobileNoTextField.text = ""
                        self.passwordTextField.text = ""
                        
                        //Alert for successful registration
                        self.alertForSucessReg()
                        
                        
                        
                    }else{
                        //alert for invalid password
                       self.alertForInvalidPassword()
                    }
                    
                }else{
                    //alert for invalid email
                   self.alertForInvalidEmail()
                }
            
            }else{
                //Alert for empty record
            self.alertforEmptyrecord()
            }
        }
        
    }
    

}

//MARK:-UITextFieldDelegate
extension RegistrationViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//MARK:-Alert Functions

extension RegistrationViewController {
    
    func alertForSucessReg(){
        let alertController = UIAlertController(title: "Success", message: "Your registration is successful", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            let login_vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            
            self.present(login_vc, animated: true, completion: nil)
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
        
    
    func alertForInvalidPassword(){
        let alertController = UIAlertController(title: "Invalid Password", message: "Please enter valid password..\n\n Password patteren must satsify the following conditions \n 8 characters total \n atleast one uppercase,\n atleast one digit,\n at least one lowercase,\n 8 characters total", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func alertForInvalidEmail(){
        let alertController = UIAlertController(title: "Invalid Email", message: "Please enter valid Email ID", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func alertforEmptyrecord(){
        //Alert for empty record
        let alertController = UIAlertController(title: "Invalid Details", message: "Please enter valid details", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}


////MARK:-Functions for Handling Managed Objects
//extension RegistrationViewController{
//    func toSave(withFirstName firstName : String, withLastName lastName : String, witheMail eMail : String, withPassword passWord : String, withMobileno mobileNo : String)  {
//
//        if let applDelegate = UIApplication.shared.delegate as? AppDelegate{
//            let mob = applDelegate.persistentContainer.viewContext
//
//            if let entityDes = NSEntityDescription.entity(forEntityName: "User_details", in: mob){
//
//                let userDetails = NSManagedObject(entity: entityDes, insertInto: mob)
//
//                userDetails.setValue(firstName, forKey: "first_name")
//                userDetails.setValue(lastName, forKey: "last_name")
//                userDetails.setValue(eMail, forKey: "e_mail")
//                userDetails.setValue(passWord, forKey: "password")
//                userDetails.setValue(mobileNo, forKey: "mobile_no")
//
//                do{
//                    try mob.save()
//                }catch let error{
//                    print("Error while saving\(error.localizedDescription)")
//                }
//            }
//        }
//    }
//
//}

//MARK:- API Functions
extension RegistrationViewController {
    func requestApi()  {
        
        guard let firstNameValue = self.firstNameTextfield.text, let lastNameValue = self.lastNameTextField.text, let emailValue = self.eMailtextfield.text, let mobilenoValue = self.mobileNoTextField.text, let passWordValue = self.passwordTextField.text else {return}
        
        let postString = ["first_name" : firstNameValue , "last_name" : lastNameValue , "email" : emailValue , "mobile" : mobilenoValue , "password" : passWordValue]
        
        if let jsondataPost_reg = try? JSONSerialization.data(withJSONObject: postString, options: []){
        
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        if let url = URL(string: self.reg_API){
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            
            urlRequest.httpBody = jsondataPost_reg
            
            
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
            if let jsondata = try JSONSerialization.jsonObject(with: responsedata, options: .mutableContainers) as? NSDictionary {
                print(jsondata)
                }
         }catch let error{
            print("error on serialization:\(error.localizedDescription)")
         }

    }
}//extension API Functions END


