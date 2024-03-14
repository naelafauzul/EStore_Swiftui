//
//  ProductListView.swift
//  EStore_Swiftui
//
//  Created by Naela Fauzul Muna on 02/03/24.
//

import SwiftUI

struct ProductListView: View {
    @StateObject var productVM = ProductVM()
    let categoryId: Int
    
    var body: some View {
        NavigationStack {
            Group {
                if productVM.products.count == 0 {
                    ContentUnavailableView("No Products yet", systemImage: "cart.badge.questionmark", description: Text("Try checking another products, or you can comeback later."))
                } else {
                    List(productVM.products) { item in
                        // ProductRowView(product: item)
                        TempProductRow(product: item)
                            .swipeActions {
                                Button(role: .destructive) {
                                    Task {
                                        await productVM.deleteProduct(withId: item.id)
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                    }
                }
            }
            .navigationTitle("Products")
            .overlay {
                productVM.isLoading ? ProgressView() : nil
            }
            .task {
                await productVM.loadProducts(forCategoryId: categoryId)
            }
        }
    }
}

#Preview {
//    let vm = ProductVM()
//    vm.products = Product.dummy
    
    ProductListView(categoryId: 5)
}
