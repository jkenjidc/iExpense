//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Kenji Dela Cruz on 4/19/24.
//
import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Expense.self)
    }
}
