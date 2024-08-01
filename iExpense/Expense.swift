//
//  Expense.swift
//  iExpense
//
//  Created by Kenji Dela Cruz on 8/1/24.
//

import Foundation
import SwiftData

@Model
class Expense {
    var id = UUID()
    var name: String
    var type: String
    var amount: Double
    
    init(name: String = "Expense Title", type: String = "Personal", amount: Double = 0.0) {
        self.name = name
        self.type = type
        self.amount = amount
    }
}
