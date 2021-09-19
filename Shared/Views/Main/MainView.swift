//
//  MainView.swift
//  KcHeroesMulti (iOS)
//
//  Created by Noe Cruz Rodriguez on 19/09/2021.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    @State var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
         
            HeroesView(viewModel: HeroesViewModel())
            .tabItem {
                Image(systemName: "house")
                Text("Heroes")
            }
            .tag(0)
     
            VStack{
                Text("KeepCoders")
            }
            .tabItem {
                Image(systemName: "person.2")
                Text("KeepCoders")
            }
            .tag(1)
   
            VStack{
                // Close session
                Button(action: {
                    rootViewModel.closeSession()
                }){
                    Text("Cerrar sessión")
                }
            }
            .tabItem {
                Image(systemName: "person.2")
                Text("Configuration")
            }
            .tag(2)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
