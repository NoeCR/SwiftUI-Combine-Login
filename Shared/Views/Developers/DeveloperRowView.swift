//
//  DeveloperRowVIew.swift
//  KcHeroesMulti (iOS)
//
//  Created by Noe Cruz Rodriguez on 20/09/2021.
//

import SwiftUI

struct DeveloperRowView: View {
    @StateObject var viewModelImage = ImageViewModel()
    var developer: DeveloperModel
    
    var body: some View {
        VStack {
            if let avatar = viewModelImage.image {
                avatar
                    .resizable()
                    .frame(width: 100, height: 100, alignment: .center)
                    .padding()
            } else {
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 100, height: 100, alignment: .center)
                    .padding()
            }
            
            Text("\(developer.name) \(developer.apell1)")
        }
        .onAppear {
            // viewModelImage.loadImage(url: developer.photo)
        }
    }
}

struct DeveloperRowView_Previews: PreviewProvider {
    static var previews: some View {
        DeveloperRowView(developer: DeveloperModel(id: UUID(), apell1: "Bustos", apell2: "Esteban", bootcampo: BootCamp(id: UUID(), name: "Web X"), heros: [], email: "", photo: "https://previews.123rf.com/images/jemastock/jemastock1708/jemastock170801165/83216515-ilustraci%C3%B3n-de-vector-de-hombre-empleado-cara-persona-car%C3%A1cter-trabajo.jpg", name: "Antopni Luis"))
    }
}
