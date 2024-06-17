//
//  ContentView.swift
//  iExpense
//
//  Created by Kenji Dela Cruz on 4/19/24.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems =  UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
    }
}

struct ContentView: View {
    
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
                    HStack{
                        VStack(alignment: .leading){
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .font(item.amount > 10.0 ? 
                                  (item.amount > 100.0 ? .title : .title2)
                                  : .title3)
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                NavigationLink{
                    AddView(expenses: expenses)
                        .navigationBarBackButtonHidden()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        
    }
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}


#Preview {
    ContentView()
}
