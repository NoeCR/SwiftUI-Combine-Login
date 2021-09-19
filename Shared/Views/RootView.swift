//
//  RootView.swift
//  KcHeroesMulti (iOS)
//
//  Created by Noe Cruz Rodriguez on 19/09/2021.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    
    var body: some View {
        switch rootViewModel.status {
            case Status.none:
                LoginView()
            case Status.loading:
                Text("Loading ....")
            case Status.loaded:
                MainView()
            case Status.register:
                Text("Register")
            case Status.error(error: let errorString):
                Text("Error \(errorString)")
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
