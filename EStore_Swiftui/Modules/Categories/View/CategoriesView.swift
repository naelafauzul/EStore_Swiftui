//
//  CategoriesView.swift
//  EStore_Swiftui
//
//  Created by Naela Fauzul Muna on 14/03/24.
//

import SwiftUI

struct CategoriesView: View {
    @StateObject var categoryVM = CategoryVM()
    
    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 100), spacing: 20)
    ]
    
    var gridItemLayout = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(categoryVM.categories) { item in
                        NavigationLink(destination: ProductListView(categoryId: item.id)) {
                            CategoryItem(category: item)
                        }
                        
                    }
                }
                .padding()
            }
            .overlay {
                categoryVM.isLoading ? ProgressView() : nil
            }
            .task {
                await categoryVM.loadCategories()
            }
            .navigationTitle("Categories")
        }
    }
}

#Preview {
    CategoriesView()
}
