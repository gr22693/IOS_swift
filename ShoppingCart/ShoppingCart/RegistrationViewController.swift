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
                
                //Alert for invalid email
                if emailTextField.isValidEmail {
                    print("valid email")
                    
                    //alert for invalid password
                    if isValidPassword(withteststr: passwordField){
                        print("valid password")
                        toSave(withFirstName: firstnameTextfield, withLastName: lastNameTextField, witheMail: emailTextField, withPassword: passwordField, withMobileno: mobilenofield)
                        
                        self.firstNameTextfield.text = ""
                        self.lastNameTextField.text = ""
                        self.eMailtextfield.text = ""
                        self.mobileNoTextField.text = ""
                        self.passwordTextField.text = ""
                        
                        let alertController = UIAlertController(title: "Success", message: "Your registration is successful", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                        
                        
                        
                    }else{
                        
                        let alertController = UIAlertController(title: "Invalid Password", message: "Please enter valid password..\n\n Password patteren must satsify the following conditions \n 8 characters total \n atleast one uppercase,\n atleast one digit,\n at least one lowercase,\n 8 characters total", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                        
                    }
                    
                }else{
                    
                    let alertController = UIAlertController(title: "Invalid Email", message: "Please enter valid Email ID", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                 alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                
            
            }else{
                //Alert for empty record
                let alertController = UIAlertController(title: "Invalid Details", message: "Please enter valid details", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)            }
        }
        
    }
    

}

//MARK:-UITE
extension RegistrationViewController : UITextFieldDelegate{
    
    
    
}


//MARK:- e-Mail and Password validation functions
extension RegistrationViewController{
    
    
    
    
    func isValidPassword(withteststr testStr:String?) -> Bool {
        guard testStr != nil else { return false }
        
        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        // 8 characters total
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        return passwordTest.evaluate(with: testStr)
    }
}


//MARK:-Functions for Handling Managed Objects
extension RegistrationViewController{
    func toSave(withFirstName firstName : String, withLastName lastName : String, witheMail eMail : String, withPassword passWord : String, withMobileno mobileNo : String)  {
        
        if let applDelegate = UIApplication.shared.delegate as? AppDelegate{
            let mob = applDelegate.persistentContainer.viewContext
        
            if let entityDes = NSEntityDescription.entity(forEntityName: "User_details", in: mob){
                
                let userDetails = NSManagedObject(entity: entityDes, insertInto: mob)
                
                userDetails.setValue(firstName, forKey: "first_name")
                userDetails.setValue(lastName, forKey: "last_name")
                userDetails.setValue(eMail, forKey: "e_mail")
                userDetails.setValue(passWord, forKey: "password")
                userDetails.setValue(mobileNo, forKey: "mobile_no")
                
                do{
                    try mob.save()
                }catch let error{
                    print("Error while saving\(error.localizedDescription)")
                }
            }
        }
    }
    
}


