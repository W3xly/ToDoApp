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
    
    @State private var name: String = ""
    @State private var priority: String = "Normal"
    
    let priorities = ["High", "Normal", "Low"]
    
    //MARK: - Body
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Todo", text: $name)
                    
                    Picker("Priority", selection: $priority) {
                        ForEach(priorities, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Button(action: {
                        print("DEBUG: Save item..")
                    }) {
                        Text("Save")
                    }
                }
                Spacer()
            } // VStack
                .navigationBarTitle("New Todo", displayMode: .inline)
        } // NavigationView
    }
}

struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}
