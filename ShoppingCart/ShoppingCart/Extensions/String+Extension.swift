//
//  String+Extension.swift
//  ShoppingCart
//
//  Created by gowthamraj on 11/04/18.
//  Copyright © 2018 gowthamraj. All rights reserved.
//

import Foundation

extension String {
    
    var isValidEmail: Bool {
        
        let regex = "[A-Za-z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}"
        
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with:self)
    }
    
    var isValidPassword : Bool {
   // guard testStr != nil else { return false }
    
    // at least one uppercase,
    // at least one digit
    // at least one lowercase
    // 8 characters total
    let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
    return passwordTest.evaluate(with: self)
    }
}
