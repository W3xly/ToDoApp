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
    
    @State private var showingAddTodoView: Bool = false
    
    //MARK: - Body
    var body: some View {
        NavigationView {
            List(0..<5) { item in
                Text("Hello!")
            } //END: List
            .navigationBarTitle("Todo", displayMode: .inline)
            .navigationBarItems(trailing:
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
        } //END: NavigationView
    } //END: body
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
