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
        ToDoItems(itemText: "Improve the new amazing app!", isCompleted: false)
    ]
    
    @State private var itemAddText: String = ""
    
    func addNewItemText() {
        if !itemAddText.isEmpty {
            itemLists.insert(ToDoItems(itemText: itemAddText), at: itemLists.endIndex)
            itemAddText = ""
        }
    }
    // This is function is swiping from right into left and it will show "Delete" is button.
    func deleteItemText(at offsets: IndexSet) {
        itemLists.remove(atOffsets: offsets)
    }
    
    // This is function is toggle that button will be changed to 'Completed(true)' or 'Not completed(false) in bool'.
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
                        Button {
                            items.isCompleted.toggle()
                        } label: {
                            VStack.init(alignment: .leading) {
                                Text(items.itemText)
                                Text(items.isCompleted ? "Mark as not completed" : "Mark as completed")
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 6)
                                    .background(items.isCompleted ? .red : .green)
                                    .foregroundStyle(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                            }
                        }.buttonStyle(.plain)
                        .padding(6)
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
