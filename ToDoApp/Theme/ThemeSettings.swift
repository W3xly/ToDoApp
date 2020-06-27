//
//  ThemeSettings.swift
//  ToDoApp
//
//  Created by Johana Šlechtová on 27/06/2020.
//  Copyright © 2020 Jan Podmolík. All rights reserved.
//

import SwiftUI

class ThemeSettings: ObservableObject {
    @Published var themeIndex: Int = UserDefaults.standard.integer(forKey: "themeIndex") {
        didSet {
            UserDefaults.standard.set(self.themeIndex, forKey: "themeIndex")
        }
    }
}
