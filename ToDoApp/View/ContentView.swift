//
//  ContentView.swift
//  ToDoApp
//
//  Created by Johana Šlechtová on 23/06/2020.
//  Copyright © 2020 Jan Podmolík. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: - Properties
    
    // enable to access internal storage
    @Environment(\.managedObjectContext) var managedObjectContext
    // sortDescriptor -> sorted by name -> true = alphabetical order
    @FetchRequest(entity: Todo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name, ascending: true)]) var todos: FetchedResults<Todo>
    
    @State private var showingAddTodoView: Bool = false
    @State private var animatingButton: Bool = false
    
    //MARK: - Body
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(self.todos, id: \.self) { todo in
                        HStack {
                            Text(todo.name ?? "Unknown")
                            Spacer()
                            Text(todo.priority ?? "Unknown")
                        }
                    } //END: ForEach
                        .onDelete(perform: deleteTodo)
                } //END: List
                    .navigationBarTitle("Todo", displayMode: .inline)
                    .navigationBarItems(
                        leading: EditButton(),
                        trailing:
                        Button(action: {
                            self.showingAddTodoView.toggle()
                        }, label: {
                            Image(systemName: "plus")
                        }) //END: Button
                            .sheet(isPresented: $showingAddTodoView, content: {
                                // passing manage object here
                                AddTodoView().environment(\.managedObjectContext, self.managedObjectContext)
                            })
                )
                //MARK: - Empty todo view
                if todos.count == 0 {
                    EmptyListView()
                }
            } //END: ZStack
                .sheet(isPresented: $showingAddTodoView, content: {
                    // passing manage object here
                    AddTodoView().environment(\.managedObjectContext, self.managedObjectContext)
                })
                .overlay(
                    ZStack {
                        Group {
                        Circle()
                            .fill(Color.blue)
                            .opacity(self.animatingButton ? 0.2 : 0)
                            .scaleEffect(self.animatingButton ? 1 : 0)
                            .frame(width: 68, height: 68, alignment: .center)
                            Circle()
                            .fill(Color.blue)
                            .opacity(self.animatingButton ? 0.15 : 0)
                            .scaleEffect(self.animatingButton ? 1 : 0)
                            .frame(width: 88, height: 88, alignment: .center)
                        }
                        .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true))
                        Button(action: {
                            self.showingAddTodoView.toggle()
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .background(Circle().fill(Color("ColorBase")))
                                .frame(width: 48, height: 48, alignment: .center)
                        } //END: Button
                            .onAppear {
                                self.animatingButton.toggle()
                        }
                    } //END: ZStack
                        .padding(.bottom, 15)
                        .padding(.trailing, 15)
                        ,alignment: .bottomTrailing
            )
        } //END: NavigationView
    } //END: body
    
    //MARK: - Helpers
    
    // specialy made for .onDelete function that take func of this type
    private func deleteTodo(at offsets: IndexSet) {
        for index in offsets {
            let todo = todos[index]
            managedObjectContext.delete(todo)
            do {
                try managedObjectContext.save()
            } catch {
                print("DEBUG: error: \(error.localizedDescription)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate)
            .persistentContainer.viewContext
        return ContentView().environment(\.managedObjectContext, context)
    }
}
