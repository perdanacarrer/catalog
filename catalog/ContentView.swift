//
//  ContentView.swift
//  catalog
//
//  Created by oscar perdana on 28/05/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var catalogStore = CatalogStore()
    @State private var searchText = ""
    @State private var showFavoritesOnly = false

    var filteredProducts: [Catalog] {
        let filtered = catalogStore.products.filter { product in
            (product.name.contains(searchText) || product.description.contains(searchText) || searchText.isEmpty) &&
            (!showFavoritesOnly || product.isFavorite)
        }
        return filtered
    }

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Show Favorites Only")
                }
                .padding()

                List {
                    ForEach(filteredProducts) { product in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(product.name)
                                    .font(.headline)
                                Text(product.description)
                                    .font(.subheadline)
                            }
                            Spacer()
                            Button(action: {
                                catalogStore.toggleFavorite(for: product)
                            }) {
                                Image(systemName: product.isFavorite ? "heart.fill" : "heart")
                                    .foregroundColor(product.isFavorite ? .red : .gray)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Product Catalog")
        }
    }
}

struct SearchBar: UIViewRepresentable {
    @Binding var text: String

    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
}

