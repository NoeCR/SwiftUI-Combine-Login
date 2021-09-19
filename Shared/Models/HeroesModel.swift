//
//  HeroesModel.swift
//  KcHeroesMulti (iOS)
//
//  Created by Noe Cruz Rodriguez on 19/09/2021.
//

import Foundation

struct HeroesModel: Codable, Identifiable {
    var id: UUID
    var name: String
    var description: String
    var photo: String
    var favorite: Bool?
}

struct HeroesFilterRequest: Codable {
    var name: String
}
