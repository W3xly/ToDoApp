//
//  FormRowLinkView.swift
//  ToDoApp
//
//  Created by Johana Šlechtová on 26/06/2020.
//  Copyright © 2020 Jan Podmolík. All rights reserved.
//

import SwiftUI

struct FormRowLinkView: View {
    //MARK: - Properties
    
    var icon: String
    var color: Color
    var text: String
    var link: String
    
    //MARK: - Body
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(color)
                Image(systemName: icon)
                    .foregroundColor(.white)
            } //END: ZStack
                .frame(width: 36, height: 36, alignment: .center)
            
            Text(text)
                .foregroundColor(.gray)
            
            Spacer()
            
            Button(action: {
                guard let url = URL(string: self.link),
                UIApplication.shared.canOpenURL(url) else { return }
                UIApplication.shared.open(url as URL)
            }) {
                Image(systemName: "chevron.right")
                    .font(.system(size: 24, weight: .semibold, design: .rounded))
            }
            .accentColor(Color(.systemGray2))
        } //END: HStack
    }
}

struct FormRowLinkView_Previews: PreviewProvider {
    static var previews: some View {
        FormRowLinkView(icon: "globe", color: .pink, text: "Website", link: "https://www.linkedin.com/in/jan-podmolik/")
            .previewLayout(.fixed(width: 375, height: 80))
            .padding()
    }
}
