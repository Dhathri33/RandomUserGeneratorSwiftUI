//
//  RandomUserGeneratorSwiftUIApp.swift
//  RandomUserGeneratorSwiftUI
//
//  Created by Dhathri Bathini on 10/22/25.
//

import SwiftUI

@main
struct RandomUserGeneratorSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(userViewModel: UserViewModel(shared: NetworkManager.shared))
        }
    }
}
