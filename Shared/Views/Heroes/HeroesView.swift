//
//  HeroesView.swift
//  KcHeroesMulti (iOS)
//
//  Created by Noe Cruz Rodriguez on 19/09/2021.
//

import SwiftUI

struct HeroesView: View {
    @StateObject var viewModel: HeroeViewModel
    @State private var filter: String = ""
    
    var body: some View {
        NavigationView {
            List {
                if let heroes = viewModel.heroes {
                    ForEach(heroes) { data in
                        NavigationLink(
                            destination: HeroesDetailView(heroe: data),
                            label: {
                                HeroeRowView(heroe: data)
                            })
                    }
                }
            }
            .navigationBarTitle("KeepCoding", displayMode: .large)
        }
        
    }
}

struct HeroesView_Previews: PreviewProvider {
    static var previews: some View {
        HeroesView(viewModel: HeroeViewModel(testing: true))
    }
}
