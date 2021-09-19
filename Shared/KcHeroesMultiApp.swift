//
//  KcHeroesMultiApp.swift
//  Shared
//
//  Created by Noe Cruz Rodriguez on 19/09/2021.
//

import SwiftUI

@main
struct KcHeroesMultiApp: App {
    @StateObject var rootViewModel: RootViewModel = RootViewModel() // ViewModel global en la APP
    
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(rootViewModel) // Se inyecta el ViewModel en el login

        }
    }
}
