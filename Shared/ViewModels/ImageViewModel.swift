//
//  ImageViewModel.swift
//  KcHeroesMulti (iOS)
//
//  Created by Noe Cruz Rodriguez on 19/09/2021.
//

import Foundation
import Combine
import SwiftUI


class ImageViewModel: ObservableObject {
    @Published var image: Image?
    
    var suscriptor = Set<AnyCancellable>()
    
    func loadImage(url: String) {
        // Control de cache ...
        
        let urlDownload = URL(string: url)!
        
        URLSession.shared
            .dataTaskPublisher(for: urlDownload)
            .map {
                UIImage(data: $0.data)
            }
            .map { image -> Image in
                Image(uiImage: image!)
            }
            .replaceError(with: Image(systemName: "person.fill"))
            .replaceNil(with: Image(systemName: "person.fill"))
            .receive(on: DispatchQueue.main)
            .sink { image in
                self.image = image
            }
            .store(in: &suscriptor)
    }
}
