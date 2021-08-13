//
//  String+Ext.swift
//  Git_July
//
//  Created by Abdusalom Hojiev on 8/13/21.
//  Copyright © 2021 Abdusalom Hojiev. All rights reserved.
//

import Foundation

extension String {
    
    
    func converToDate() -> Date? {
        
        let dateFomatter        = DateFormatter()
        dateFomatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFomatter.locale     = Locale(identifier: "en_US_POSIX")
        dateFomatter.timeZone   = .current
   
        return dateFomatter.date(from: self)
    }
    
    func converToDisplayFormat() -> String {
        guard let date = self.converToDate() else {return "N/A"}
        return date.convertToMonthYearFormat()
    }
}
