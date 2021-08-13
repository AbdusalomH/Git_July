//
//  Dates+Ext.swift
//  Git_July
//
//  Created by Abdusalom Hojiev on 8/13/21.
//  Copyright © 2021 Abdusalom Hojiev. All rights reserved.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateformatter              = DateFormatter()
        dateformatter.dateFormat       = "MMM yyyy"
        
        return dateformatter.string(from: self)
    }
 
}
