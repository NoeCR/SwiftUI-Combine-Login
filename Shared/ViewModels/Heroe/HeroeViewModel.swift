//
//  HeroesViewModel.swift
//  KcHeroesMulti (iOS)
//
//  Created by Noe Cruz Rodriguez on 19/09/2021.
//

import Foundation
import Combine

class HeroeViewModel: ObservableObject {
    @Published var heroes: [HeroeModel]?
    @Published var status = Status.none
    
    var suscriptors = Set<AnyCancellable>()
    
    init(testing: Bool = false) {
        if(testing) {
            getHerosTesting()
        }
        else {
            getHeros(filter: "")
        }
    }
    
    func getHeros(filter: String){
        self.status = Status.loading
        
        URLSession.shared
            .dataTaskPublisher(for: BaseNetwork().getSessionHeros(filter: filter))
            .tryMap{
                guard let response = $0.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                
                // Devolvemos el JSON
                return $0.data
            }
            .decode(type: [HeroeModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                    case .failure:
                        self.status = Status.error(error: "Error on find Heroes")
                    case .finished:
                        self.status = Status.loaded
                }
                
            } receiveValue: { data in
                self.heroes = data
            }
            .store(in: &suscriptors)
    }
    
    // Testing y Diseño
    func getHerosTesting() {
        self.status = Status.loading
        
        let hero1 = HeroeModel(id: UUID(), name: "Hulk", description: "Caught in a gamma bomb explosion while trying to save the life of a teenager, Dr. Bruce Banner was transformed into the incredibly powerful creature called the Hulk. An all too often misunderstood hero, the angrier the Hulk gets, the stronger the Hulk gets.", photo: "http://i.annihil.us/u/prod/marvel/i/mg/5/a0/538615ca33ab0/portrait_incredible.jpg", favorite: true)
        let hero2 = HeroeModel(id: UUID(), name: "Captain Marvel", description: "", photo: "http://i.annihil.us/u/prod/marvel/i/mg/6/80/5269608c1be7a/portrait_incredible.jpg", favorite: false)
        let hero3 = HeroeModel(id: UUID(), name: "Spider-Man", description: "Bitten by a radioactive spider, high school student Peter Parker gained the speed, strength and powers of a spider. Adopting the name Spider-Man, Peter hoped to start a career using his new abilities. Taught that with great power comes great responsibility, Spidey has vowed to use his powers to help people.", photo: "http://i.annihil.us/u/prod/marvel/i/mg/3/50/526548a343e4b/portrait_incredible.jpg", favorite: true)
        let hero4 = HeroeModel(id: UUID(), name: "Avengers", description: "Earth's Mightiest Heroes joined forces to take on threats that were too big for any one hero to tackle. With a roster that has included Captain America, Iron Man, Ant-Man, Hulk, Thor, Wasp and dozens more over the years, the Avengers have come to be regarded as Earth's No. 1 team.", photo: "http://i.annihil.us/u/prod/marvel/i/mg/9/20/5102c774ebae7/portrait_incredible.jpg", favorite: false)
        
        self.heroes = [hero1, hero2, hero3, hero4]
        self.status = Status.loaded
    }
}
