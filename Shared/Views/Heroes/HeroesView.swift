//
//  HeroesView.swift
//  KcHeroesMulti (iOS)
//
//  Created by Noe Cruz Rodriguez on 19/09/2021.
//

import SwiftUI

struct HeroesView: View {
    @StateObject var viewModel: HeroesViewModel
    @State private var filter: String = ""
    
    var body: some View {
        List {
            if let heroes = viewModel.heroes {
                ForEach(heroes) { data in
                    NavigationLink(
                        destination: Text("\(data.name)"),
                        label: {
                            HeroesRowView(heroe: data)
                        })
                }
            }
        }
    }
}

struct HeroesView_Previews: PreviewProvider {
    static var previews: some View {
        HeroesView(viewModel: HeroesViewModel(testing: true))
    }
}
