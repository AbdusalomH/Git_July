//
//  ErrorMessages.swift
//  Git_July
//
//  Created by Abdusalom Hojiev on 8/9/21.
//  Copyright © 2021 Abdusalom Hojiev. All rights reserved.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername    = "This user name is invalid, Please try again"
    case unableToComplete   = "Unable to complete you request, Please check your internet"
    case invalidResponse    = "Bad response from server, please try again"
    case invalidData        = "no data available on server, please check again"
}
