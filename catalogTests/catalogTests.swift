//
//  catalogTests.swift
//  catalogTests
//
//  Created by oscar perdana on 28/05/24.
//

import XCTest
@testable import catalog

class ProductStoreTests: XCTestCase {

    var productStore: CatalogStore!

    override func setUp() {
        super.setUp()
        productStore = CatalogStore()
    }

    func testToggleFavorite() {
        let product = productStore.products[0]
        XCTAssertFalse(product.isFavorite)

        productStore.toggleFavorite(for: product)
        XCTAssertTrue(productStore.products[0].isFavorite)

        productStore.toggleFavorite(for: product)
        XCTAssertFalse(productStore.products[0].isFavorite)
    }

    func testFilteredProducts() {
        let favoriteProduct = productStore.products[0]
        productStore.toggleFavorite(for: favoriteProduct)
        let filteredProducts = productStore.filteredProducts(showFavorites: true)
        XCTAssertEqual(filteredProducts.count, 1)
        XCTAssertTrue(filteredProducts[0].isFavorite)
    }
}

