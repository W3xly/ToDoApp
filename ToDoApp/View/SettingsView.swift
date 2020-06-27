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
    @EnvironmentObject var icons: IconNames
    
    let themes: [Theme] = themeData
    @ObservedObject var theme = ThemeSettings()
    
    //MARK: - Body
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                Form {
                    //MARK: - AppIcons
                    Section(header: Text("Choose the app icon")) {
                        Picker(selection: $icons.currentIndex, label:
                            
                            HStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                                        .strokeBorder(Color.primary, lineWidth: 2)
                                    
                                    Image(systemName: "paintbrush")
                                        .font(.system(size: 28, weight: .regular, design: .default))
                                        .foregroundColor(Color.primary)
                                }
                                .frame(width: 44, height: 44)
                                Text("App Icons".uppercased())
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.primary)
                            } //END: HStack
                            
                        ) {
                            ForEach(0..<icons.iconNames.count) { index in
                                HStack {
                                    Image(uiImage: UIImage(named: self.icons.iconNames[index] ?? "Blue") ?? UIImage())
                                        .renderingMode(.original)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 44, height: 44)
                                        .cornerRadius(8)
                                    
                                    Spacer().frame(width: 8)
                                    
                                    Text(self.icons.iconNames[index] ?? "Blue")
                                        .frame(alignment: .leading)
                                } //END: HStack
                                    .padding(3)
                            } //END: ForEach
                        } //END: Picker
                            
                            //MARK: - Picker Brain
                            .onReceive([self.icons.currentIndex].publisher.first()) { value in
                                // Get current icon index
                                // alternateIconName = The name of Alternate icon if it's set, otherwise nil.
                                let index = self.icons.iconNames.firstIndex(of: UIApplication.shared.alternateIconName) ?? 0
                                print("DEBUG: Last Icon Index? : \(index), Next Icon Index: \(value)")
                                // Check the index of new icon, if it's different from current icon index -> continue through function
                                if index != value {
                                    // Set new App Icon (setAlternateIconName)
                                    UIApplication.shared.setAlternateIconName(self.icons.iconNames[value]) { (error) in
                                        if let error = error {
                                            print("DEBUG: \(error.localizedDescription)")
                                        } else {
                                            print("DEBUG: Success! Icon has changed..")
                                        }
                                    }
                                }
                        }
                    } //END: Section
                        .padding(.vertical, 3)
                    
                    //MARK: - App Theme
                    
                    Section(header:
                        HStack {
                            Text("Choose the app theme")
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 10, height: 10)
                                .foregroundColor(themes[self.theme.themeIndex].themeColor)
                        }
                    ) {
                        List {
                            ForEach(themes, id: \.id) { item in
                                Button(action: {
                                    self.theme.themeIndex = item.id
                                }) {
                                    HStack {
                                        Image(systemName: "circle.fill")
                                            .foregroundColor(item.themeColor)
                                        Text(item.themeName)
                                    }
                                } //END: Button
                                    .accentColor(Color.primary)
                            }
                        }
                    } //END: Section
                    
                    //MARK: - LinkViews
                    Section(header: Text("Follow me on social media")) {
                        FormRowLinkView(icon: "globe", color: Color(#colorLiteral(red: 0.1576931477, green: 0.2425388396, blue: 0.2885012627, alpha: 1)), text: "Linked In", link: "https://www.linkedin.com/in/jan-podmolik/")
                        FormRowLinkView(icon: "link", color: Color(#colorLiteral(red: 0.1148131862, green: 0.6330112815, blue: 0.9487846494, alpha: 1)), text: "Twitter", link: "https://twitter.com/JanPodmolik")
                        FormRowLinkView(icon: "heart", color: Color(#colorLiteral(red: 0.88390553, green: 0.2188745141, blue: 0.3934468627, alpha: 1)), text: "Instagram", link: "https://www.instagram.com/wex.ly")
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
            .accentColor(themes[self.theme.themeIndex].themeColor)
            .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(IconNames())
    }
}
