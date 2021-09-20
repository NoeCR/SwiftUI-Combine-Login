//
//  HeroesDetailView.swift
//  KcHeroesMulti (iOS)
//
//  Created by Noe Cruz Rodriguez on 19/09/2021.
//

import SwiftUI

struct HeroesDetailView: View {
    @ObservedObject private var viewModel = ImageViewModel()
    var heroe: HeroeModel
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                if let photo = viewModel.image {
                    photo
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                        .padding([.trailing, .leading], 20)
                        .opacity(0.8)
                }
                else {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                        .padding([.trailing, .leading], 20)
                        .opacity(0.8)
                }
                
                // Description
                Text("\(heroe.description)")
                    .foregroundColor(.gray)
                    .font(.caption2)
            }
            .onAppear {
                // Si tiene imagen no hace la llamada al loadImage del viewModel
                if let _ = viewModel.image {} else { viewModel.loadImage(url: heroe.photo) }
            }
            .navigationTitle(heroe.name)
        }
    }
}

struct HeroesDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HeroesDetailView(heroe: HeroeModel(id: UUID(), name: "Hulk", description: "Caught in a gamma bomb explosion while trying to save the life of a teenager, Dr. Bruce Banner was transformed into the incredibly powerful creature called the Hulk. An all too often misunderstood hero, the angrier the Hulk gets, the stronger the Hulk gets.", photo: "http://i.annihil.us/u/prod/marvel/i/mg/5/a0/538615ca33ab0/portrait_incredible.jpg", favorite: true))
    }
}
