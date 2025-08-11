//
//  ContentView.swift
//  To-Do List
//
//  Created by Denys on 2025-08-10.
//

import SwiftUI

struct ContentView: View {
    
struct ToDoItems: Identifiable {
    let id = UUID()
    var itemText = ""
    var isCompleted = false
}
    @State private var itemLists: [ToDoItems] = [
        ToDoItems(itemText: "Learn Swift", isCompleted: true),
        ToDoItems(itemText: "Build new app 'To-Do List'", isCompleted: false),
        ToDoItems(itemText: "Get an offer with job", isCompleted: false),
        ToDoItems(itemText: "Leave Walmart", isCompleted: false)
    ]
    
    @State private var itemAddText: String = ""
    
    func addNewItemText() {
        if !itemAddText.isEmpty {
            itemLists.insert(ToDoItems(itemText: itemAddText), at: itemLists.endIndex)
            itemAddText = ""
        }
    }
    
    func deleteItemText(at offsets: IndexSet) {
        itemLists.remove(atOffsets: offsets)
    }
    
    func toggleCompletion(for item: ToDoItems) {
        if let index = itemLists.firstIndex(where: { $0.id == item.id }) {
            itemLists[index].isCompleted.toggle()
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach($itemLists) { $items in
                        HStack {
                            Image(systemName: items.isCompleted ? "checkmark.circle.fill" : "checkmark.circle")
                                .foregroundStyle(items.isCompleted ? .green : .black)
                                .font(.system(size: 24))
                            Text(items.itemText)
                                .bold(items.isCompleted)
                        }.padding(6)
                    }.onDelete(perform: deleteItemText)
                }
                HStack {
                    TextField("Add something...", text: $itemAddText)
                    Button {
                        addNewItemText()
                    } label: {
                        Image(systemName: "plus.circle").font(.system(size: 24))
                    }

                }.padding()
            }.navigationTitle("To-Do List")
        }
    }
}

#Preview {
    ContentView()
}
