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

    
    var userDetailArray : [NSManagedObject] = []
    
    @IBOutlet weak var usernametextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//     self.usernametextField.delegate = self
//      self.passwordTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        if let email = self.usernametextField.text, email.isValidEmail {
            
        }
    }
    
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
//MARK:- supporting functions
extension LoginViewController {
    
   
    
}


//MARK:-UITextFieldDelegate
extension LoginViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//Mark:- ManagedObjects to validate login details
extension LoginViewController{
    func toFetchTheEmail(){
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            let mob = appDelegate.persistentContainer.viewContext
            
            let fetchinreq = NSFetchRequest<NSManagedObject>(entityName: "User_details")
            
            do{
                self.userDetailArray = try mob.fetch(fetchinreq)
            }catch let error{
                print("error while fetching \(error.localizedDescription)")
            }
        }
        
    }
    
}

