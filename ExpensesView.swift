//
//  ExpensesView.swift
//  iExpense
//
//  Created by Kenji Dela Cruz on 8/1/24.
//

import SwiftData
import SwiftUI

struct ExpensesView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [Expense]
    var body: some View {
        List {
            ForEach(expenses) { item in
                HStack{
                    VStack(alignment: .leading){
                        Text(item.name)
                            .font(.headline)
                        Text(item.type)
                    }
                    Spacer()
                    Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .font(getFont(amount: item.amount))
                }
            }
            .onDelete(perform: removeItem)
        }
    }
    init(expenseType: String, sortOrder:[SortDescriptor<Expense>]) {
        _expenses = Query(filter: #Predicate<Expense> { expense in
            expense.type.contains(expenseType)
        }, sort: sortOrder)
    }
    
    func removeItem(at offsets: IndexSet) {
        for offset in offsets {
            let expense = expenses[offset]
            modelContext.delete(expense)
        }
    }
    
    func getFont(amount: Double) -> Font {
        return amount > 10.0 ?
              (amount > 100.0 ? .title : .title2)
              : .title3
    }
}

#Preview {
    ExpensesView(expenseType: "Business", sortOrder: [SortDescriptor(\Expense.name)])
        .modelContainer(for: Expense.self)
}
