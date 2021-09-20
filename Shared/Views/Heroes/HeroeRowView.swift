//
//  HeroesRowView.swift
//  KcHeroesMulti (iOS)
//
//  Created by Noe Cruz Rodriguez on 19/09/2021.
//

import SwiftUI

struct HeroeRowView: View {
    // Utilizamos ObservedObject para cuadno muera la vista desuscribirse del observable
    @ObservedObject private var viewModel = ImageViewModel()
    var heroe: HeroeModel
        
    var body: some View {
        VStack{
            // Si hay foto la mostramos
            if let photo = viewModel.image {
                photo
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding([.leading, .trailing], 20)
                    .opacity(0.6)
            }
            else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding([.leading, .trailing], 20)
                    .opacity(0.6)
            }
            

            
            Text("\(heroe.name)")
                .font(.title)
                .foregroundColor(.gray)
                .bold()
            
            if(heroe.favorite!){
                Image(systemName: "heart.circle")
                    .resizable()
                    .foregroundColor(.red)
                    .frame(width: 40, height: 40, alignment: .center)
            } else {
                Image(systemName: "heart.circle")
                    .resizable()
                    .foregroundColor(.gray)
                    .frame(width: 40, height: 40, alignment: .center)
            }
        }
        .onAppear {
            viewModel.loadImage(url: heroe.photo)
        }
    }
}

struct HeroesRowView_Previews: PreviewProvider {
    static var previews: some View {
        HeroeRowView(heroe: HeroeModel(id: UUID(), name: "Hulk", description: "Caught in a gamma bomb explosion while trying to save the life of a teenager, Dr. Bruce Banner was transformed into the incredibly powerful creature called the Hulk. An all too often misunderstood hero, the angrier the Hulk gets, the stronger the Hulk gets.", photo: "http://i.annihil.us/u/prod/marvel/i/mg/5/a0/538615ca33ab0/portrait_incredible.jpg", favorite: true))
        
    }
}
