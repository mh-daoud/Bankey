//
//  Decimal+Extensions.swift
//  Bankey
//
//  Created by admin on 20/11/2023.
//

import Foundation

extension Decimal {
    var doubleValue : Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
