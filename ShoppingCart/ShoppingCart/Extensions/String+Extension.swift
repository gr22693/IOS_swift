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
}
