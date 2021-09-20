//
//  DeveloperViewModel.swift
//  KcHeroesMulti (iOS)
//
//  Created by Noe Cruz Rodriguez on 19/09/2021.
//

import Foundation
import Combine

class DeveloperViewModel: ObservableObject {
    @Published var developers: [DeveloperModel]?
    @Published var status = Status.none
    @Published var bootcamps: [BootCamp]?
    
    var suscriptors = Set<AnyCancellable>()
    
    init(testing: Bool = false) {
        if(testing) {
            getBootCampsList()
            getDevelopersTesting()
        }
        else {
            getDevelopers()
        }
    }
    
    func getDevelopers() {
        self.status = Status.loading
        
        URLSession.shared
            .dataTaskPublisher(for: BaseNetwork().getSessionDevelopers())
            .tryMap {
                guard let response = $0.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                
                // Devolvemos el JSON
                return $0.data
            }
            .decode(type: [DeveloperModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                    case .failure:
                        self.status = Status.error(error: "Error llamando a los Developers al servidor")
                    case .finished:
                        self.status = Status.loaded
                }
            } receiveValue: { data in
                self.developers = data
            }
            .store(in: &suscriptors)
    }
    
    // Testing and Design
    func getBootCampsList() {
        self.bootcamps = [BootCamp(id: UUID(), name: "Mobile XII"), BootCamp(id: UUID(), name: "Web X")];
    }
    
    func getDevelopersTesting() {
        let b1 = BootCamp(id: UUID(), name: "Mobile XII")
        let b2 = BootCamp(id: UUID(), name: "Web X")
        
        //Creo varios developers
        
        let d1 = DeveloperModel(id: UUID(), apell1: "Bustos", apell2: "Esteban", bootcampo: b1, heros: [], email: "", photo: "https://previews.123rf.com/images/jemastock/jemastock1708/jemastock170801165/83216515-ilustración-de-vector-de-hombre-empleado-cara-persona-carácter-trabajo.jpg", name: "Jose Luis")
        
        let d2 = DeveloperModel(id: UUID(), apell1: "Bustos", apell2: "Esteban", bootcampo: b1, heros: [], email: "", photo: "https://previews.123rf.com/images/jemastock/jemastock1708/jemastock170801165/83216515-ilustración-de-vector-de-hombre-empleado-cara-persona-carácter-trabajo.jpg", name: "Gema Luis")
        
        let d3 = DeveloperModel(id: UUID(), apell1: "Bustos", apell2: "Esteban", bootcampo: b2, heros: [], email: "", photo: "https://previews.123rf.com/images/jemastock/jemastock1708/jemastock170801165/83216515-ilustración-de-vector-de-hombre-empleado-cara-persona-carácter-trabajo.jpg", name: "Antopni Luis")
        
        let d4 = DeveloperModel(id: UUID(), apell1: "Bustos", apell2: "Esteban", bootcampo: b2, heros: [], email: "", photo: "https://previews.123rf.com/images/jemastock/jemastock1708/jemastock170801165/83216515-ilustración-de-vector-de-hombre-empleado-cara-persona-carácter-trabajo.jpg", name: "Raul Luis")
        
        
        
        self.developers = [d1,d2,d3,d4]
    }
}
