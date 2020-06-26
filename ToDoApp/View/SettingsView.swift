//
//  SettingsView.swift
//  ToDoApp
//
//  Created by Johana Šlechtová on 25/06/2020.
//  Copyright © 2020 Jan Podmolík. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    //MARK: - Properties
    
    @Environment(\.presentationMode) var presentationMode
    
    //MARK: - Body
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                Form {
                    //MARK: - LinkViews
                    Section(header: Text("Follow me on social media")) {
                        FormRowLinkView(icon: "globe", color: Color.pink, text: "Linked In", link: "https://www.linkedin.com/in/jan-podmolik/")
                        FormRowLinkView(icon: "link", color: Color.pink, text: "Twitter", link: "https://twitter.com/JanPodmolik")
                        FormRowLinkView(icon: "heart", color: Color.pink, text: "Instagram", link: "https://www.instagram.com/wex.ly")
                    } //END: Section
                    .padding(.vertical, 3)
                    //MARK: - StaticViews
                    Section(header: Text("About the application")) {
                        FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Todo")
                        FormRowStaticView(icon: "checkmark.seal", firstText: "Compatability", secondText: "iPhone, iPad")
                        FormRowStaticView(icon: "keyboard", firstText: "Developer", secondText: "Jan Podmolík")
                        FormRowStaticView(icon: "paintbrush", firstText: "Designer", secondText: "Jan Podmolík")
                        FormRowStaticView(icon: "flag", firstText: "Version", secondText: "1.0.0")
                    } //END: Section
                } //END: Form
                    .listStyle(GroupedListStyle())
                    .environment(\.horizontalSizeClass, .regular)
                // Footer
                Text("Copyright © All rights reserved. \nBetter Apps ♡ Less Code")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding(.top, 6)
                    .padding(.bottom, 8)
                    .foregroundColor(.secondary)
            } //END: VStack
            .navigationBarItems(trailing:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                    }) {
                       Image(systemName: "xmark")
                })
                .navigationBarTitle("Settings", displayMode: .inline)
                .background(Color("ColorBackground")
                .edgesIgnoringSafeArea(.all)
            )
            
        } //END: NavigationView
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
