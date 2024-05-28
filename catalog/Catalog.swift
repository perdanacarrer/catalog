//
//  Catalog.swift
//  catalog
//
//  Created by oscar perdana on 28/05/24.
//

import Foundation

struct Catalog: Identifiable, Codable {
    let id: Int
    let name: String
    let description: String
    var isFavorite: Bool = false
}
