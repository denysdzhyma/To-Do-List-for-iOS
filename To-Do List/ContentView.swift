//
//  ContentView.swift
//  To-Do List
//
//  Created by Denys on 2025-08-10.
//

import SwiftUI

struct ToDoItems: Identifiable {
    let id = UUID()
    var itemText = ""
    var isCompleted = false
}

struct TodoDetailView: View {
    let item: ToDoItems
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(item.itemText)
                .font(.largeTitle)
            Text("Status: \(item.isCompleted ? "Completed" : "Not Completed")")
                .font(.headline)
            Spacer()
        }
        .padding()
        .navigationTitle("Task Details")
    }
}

struct ContentView: View {
    @State private var itemLists: [ToDoItems] = [
        ToDoItems(itemText: "Learn Swift", isCompleted: true),
        ToDoItems(itemText: "Build new app 'To-Do List'", isCompleted: false),
        ToDoItems(itemText: "Improve the new amazing app!", isCompleted: false)
    ]
    
    @State private var itemAddText: String = ""
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach($itemLists) { $item in
                        NavigationLink(destination: TodoDetailView(item: item)) {
                            HStack {
                                Button {
                                    toggleCompletion(for: item)
                                } label: {
                                    Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "checkmark.circle")
                                        .foregroundStyle(item.isCompleted ? .green : .black)
                                }
                                .buttonStyle(.plain)
                                    Text(item.itemText)
                                        .bold(item.isCompleted)
                                }
                                .font(.system(size: 20))
                                .padding(.vertical, 10)
                        }
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
}



#Preview {
    ContentView()
}
