//
//  KeyChain.swift
//  KcHeroesMulti (iOS)
//
//  Created by Noe Cruz Rodriguez on 19/09/2021.
//

import Foundation
import KeychainSwift

// discardableResult -> podemos omitir el resultado para que no nos marque warning por no usar el valor
// Así no obliga a usar o definir una variable para acumular la respuesta
@discardableResult func saveKC(key: String, value: String) -> Bool {
    if let data = value.data(using: .utf8) {
        let keyChain = KeychainSwift()
        
        keyChain.set(data, forKey: key)
        
        return true
    } else {
        return false
    }
}

func loadKC(key: String) -> String? {
    let keyChain = KeychainSwift()
    
    if let data = keyChain.get(key) {
        return data
    }else {
        return ""
    }
}

func deleteKC(key: String) -> Bool {
    let keyChain = KeychainSwift()
    
    return keyChain.delete(key)
}
