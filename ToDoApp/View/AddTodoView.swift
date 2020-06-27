//
//  AddTodoView.swift
//  ToDoApp
//
//  Created by Johana Šlechtová on 23/06/2020.
//  Copyright © 2020 Jan Podmolík. All rights reserved.
//

import SwiftUI

struct AddTodoView: View {
    
    //MARK: - Properties
    
    // enable to access internal storage
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name: String = ""
    @State private var priority: String = "Normal"
    
    let priorities = ["High", "Normal", "Low"]
    
    @State private var errorShowing: Bool = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    
    @ObservedObject var theme = ThemeSettings()
    var themes: [Theme] = themeData
    
    
    //MARK: - Body
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading, spacing: 20) {
                    TextField("Todo", text: $name)
                        .padding()
                        .background(Color(UIColor.tertiarySystemFill))
                        .cornerRadius(9)
                        .font(.system(size: 24, weight: .bold, design: .default))
                    Picker("Priority", selection: $priority) {
                        ForEach(priorities, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Button(action: {
                        if self.name != "" {
                            let todo = Todo(context: self.managedObjectContext)
                            todo.name = self.name
                            todo.priority = self.priority
                            do {
                                try self.managedObjectContext.save()
                            }
                            catch {
                                print("DEBUG: Error: \(error.localizedDescription)")
                            }
                        } else {
                            self.errorShowing = true
                            self.errorTitle = "Invalid name"
                            self.errorMessage = "Make sure to enter name of new todo item."
                            return
                        }
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Save")
                            .font(.system(size: 24, weight: .bold, design: .default))
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(themes[self.theme.themeIndex].themeColor)
                            .cornerRadius(9)
                            .foregroundColor(.white)
                    } //END: Button
                } //END: VStack
                    .padding(.horizontal)
                    .padding(.vertical, 30)
                
                Spacer()
                
            } //END: VStack
                .navigationBarTitle("New Todo", displayMode: .inline)
                .navigationBarItems(trailing:
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                    }))
                .alert(isPresented: $errorShowing, content: {
                    Alert(title: Text(errorTitle),
                          message: Text(errorMessage),
                          dismissButton: .default(Text("OK")))
                })
        } //END: NavigationView
        .accentColor(themes[self.theme.themeIndex].themeColor)
        .navigationViewStyle(StackNavigationViewStyle())
    } //END: body
}

struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}
