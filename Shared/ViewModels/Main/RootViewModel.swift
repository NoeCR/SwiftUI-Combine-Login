//
//  RootViewModel.swift
//  KcHeroesMulti (iOS)
//
//  Created by Noe Cruz Rodriguez on 19/09/2021.
//

import Foundation
import Combine

public let CONST_TOKEN_ID = "tokenJWTKeyChainAppKeepCodingBoot12"

class RootViewModel: ObservableObject {
    @Published var status: Status = Status.none // Estado inicial de las llamadas de red
    @Published var isLogged: Bool = false // Indica si esta logado
    @Published var tokenJWT: String = "" { // Token del servidor
        didSet{
            // Grabamos en el KeyChain
            saveKC(key: CONST_TOKEN_ID, value: tokenJWT)
            
                if tokenJWT.count > 0 {
                        isLogged = true
                }
            print("Token del Login \(tokenJWT)")
            
        }
    }
    
    var suscriptors = Set<AnyCancellable>()
    
    init() {
        // comprobar si tenemos almancenado el token para logear al usuario
        logedUserControl()
    }
    
    func logedUserControl() {
        let storedToken = loadKC(key: CONST_TOKEN_ID)
        
        if let token = storedToken {
            self.tokenJWT = token
            
            if token.count > 0 {
                status = Status.loaded
                isLogged = true
            }
        
        }
    }
    
    
    func login(email: String, password: String) {
        status = Status.loading
        
        URLSession.shared
            .dataTaskPublisher(for: BaseNetwork().getSessionLogin(email: email, password: password))
            .tryMap{
                guard let response = $0.response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                
                // Si la respuesta es correcta, extraemos el token
                return String(decoding: $0.data, as: UTF8.self)
            }
            .receive(on: DispatchQueue.main) // Se lo pasamos al hilo principal de ejecución
            .sink{ completion in
                switch completion {
                    case .failure:
                        self.status = Status.error(error: "Usuario y/o clave erronea")
                    case .finished:
                        self.status = Status.loaded
                }
            } receiveValue: { data in
                self.tokenJWT = data
            }
            .store(in: &suscriptors)
    }
    
    func closeSession() {
        self.tokenJWT = ""
        self.isLogged = false
        self.status = Status.none
    }
}
