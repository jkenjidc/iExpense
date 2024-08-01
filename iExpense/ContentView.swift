//
//  ContentView.swift
//  iExpense
//
//  Created by Kenji Dela Cruz on 4/19/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var showingAddExpense = false
    @Query var expenses: [Expense]
    @Environment(\.dismiss) var dismiss
    @State private var sortOrder = [
        SortDescriptor(\Expense.name),
        SortDescriptor(\Expense.amount)
    ]
    @State private var showFilterType = "e"
    
    var body: some View {
        NavigationStack {
            ExpensesView(expenseType: showFilterType, sortOrder: sortOrder)
                .navigationTitle("iExpense")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading){
                        NavigationLink{
                            AddView()
                                .navigationBarBackButtonHidden()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                    //                ToolbarItem(placement: .automatic){
                    //                    Button(showBusinessExpenses ? "Show all expenses" : "Show Business expenses") {
                    //                        showBusinessExpenses.toggle()
                    //                    }
                    //                }
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu("Sort", systemImage: "arrow.up.arrow.down"){
                            Picker("Sort", selection: $sortOrder) {
                                Text("Sort by amount")
                                    .tag([
                                        SortDescriptor(\Expense.amount),
                                        SortDescriptor(\Expense.name)
                                    ])
                                
                                Text("Sort by Name")
                                    .tag([
                                        SortDescriptor(\Expense.name),
                                        SortDescriptor(\Expense.amount)
                                        
                                    ])
                            }
                        }
                    }
                    ToolbarItem {
                        Menu("Sort", systemImage: "dollarsign.arrow.circlepath"){
                            Picker("Sort", selection: $showFilterType) {
                                Text("Show Business Only")
                                    .tag("Business")
                                
                                Text("Sort Personal Only")
                                    .tag("Personal")
                                
                                Text("Show All")
                                    .tag("e")
                            }
                        }
                    }
                }
        }
        
    }
}


#Preview {
    ContentView()
}
