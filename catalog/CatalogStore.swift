//
//  CatalogStore.swift
//  catalog
//
//  Created by oscar perdana on 28/05/24.
//

import Foundation

class CatalogStore: ObservableObject {
    @Published var products: [Catalog] = []

    init() {
        products = [
            Catalog(id: 001, name: "Apple", description: "Red Apple"),
            Catalog(id: 002, name: "Grape", description: "Purple Grape"),
            Catalog(id: 003, name: "Banana", description: "Yellow Banana"),
            Catalog(id: 004, name: "Durian", description: "Smelly Durian"),
            Catalog(id: 005, name: "Strawberry", description: "Pink Strawberry"),
            Catalog(id: 006, name: "Blackcurrant", description: "Black? Purple?"),
            Catalog(id: 007, name: "Manggo", description: "Sticky Manggo"),
            Catalog(id: 008, name: "Chocolatte", description: "Brown Chocolatte")
        ]
    }

    func toggleFavorite(for product: Catalog) {
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            products[index].isFavorite.toggle()
        }
    }

    func filteredProducts(showFavorites: Bool) -> [Catalog] {
        if showFavorites {
            return products.filter { $0.isFavorite }
        } else {
            return products
        }
    }
}
