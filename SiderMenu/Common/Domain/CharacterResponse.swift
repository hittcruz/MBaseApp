//
//  CharacterResponse.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 21/06/23.
//

import Foundation

struct CharacterModelResponse: Decodable {
    let results: [CharacterModel]
    //let products: [ProductModel]
}

struct CharacterModel: Decodable {
    let name: String
    let status: String
    let species: String
    let image: String
}

struct ProductModel: Decodable {
    let categorie: String
    let name: String
    let stock: Int
}
