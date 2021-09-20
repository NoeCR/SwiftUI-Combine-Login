//
//  DeveloperModel.swift
//  KcHeroesMulti (iOS)
//
//  Created by Noe Cruz Rodriguez on 19/09/2021.
//

import Foundation

struct DeveloperModel: Codable, Identifiable {
    let id: UUID
    let apell1, apell2: String
    let bootcampo: BootCamp
    let heros: [HeroeModel]
    let email: String
    let photo: String
    let name: String
}

struct BootCamp: Codable, Identifiable {
    let id: UUID
    let name: String
}
