//
//  BaseNetwork.swift
//  KcHeroesMulti (iOS)
//
//  Created by Noe Cruz Rodriguez on 19/09/2021.
//

import Foundation


let baseUrl = "https://kcbootcamp.herokuapp.com"

struct HTTPMethods {
    static let post = "POST"
    static let get = "GET"
    static let put = "PUT"
    static let delete = "DELETE"
}

struct HTTPHeaders {
    static let content = "application/json"
}

enum endpoints: String {
    case login = "/api/auth/login"
    case herosList = "/api/heros/all"
}


struct BaseNetwork {
    // login
    func getSessionLogin(email: String, password: String) -> URLRequest {
        let url: String = "\(baseUrl)\(endpoints.login.rawValue)"
        
        let encodeCredentials = "\(email):\(password)".data(using: .utf8)?.base64EncodedString()
        
        var segCredentials = ""
        if let credentials = encodeCredentials{
            segCredentials = "Basic \(credentials)"
        }
        
        var request: URLRequest = URLRequest(url: URL(string: url)!) // Se debería desempaquetar y no usar !
        
        request.httpMethod = HTTPMethods.post
        request.addValue(HTTPHeaders.content, forHTTPHeaderField: "Content-type")
        request.addValue(segCredentials, forHTTPHeaderField: "Authorization")
        
        return request
    }
    
    func getSessionHeros(filter: String) -> URLRequest {
        let url: String = "\(baseUrl)\(endpoints.herosList.rawValue)"
        
        var request: URLRequest = URLRequest(url: URL(string: url)!) // Se debería desempaquetar y no usar !
        
        request.httpMethod = HTTPMethods.post
        // Codificamos el filtro para enviarlo en el body
        request.httpBody = try? JSONEncoder().encode(HeroesFilterRequest(name: filter))
        request.addValue(HTTPHeaders.content, forHTTPHeaderField: "Content-type")
        
        // Obtenemos el token almacenado y lo desempaquetamos para usarlo en la llamada
        let storedToken = loadKC(key: CONST_TOKEN_ID)
        if let tokenJWT = storedToken{
            request.addValue("Bearer \(tokenJWT)", forHTTPHeaderField: "Authorization")
        }
                
        return request
    }
}
