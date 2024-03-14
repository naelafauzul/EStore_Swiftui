//
//  CategoryItem.swift
//  EStore_Swiftui
//
//  Created by Naela Fauzul Muna on 14/03/24.
//

import SwiftUI

struct CategoryItem: View {
    let category: Category
    
    var body: some View {
        VStack {
            // Using ImageUtility to extract the URL
            if let imageUrl = ImageUtility.extractImageUrl(from: category.image) {
                AsyncImage(url: imageUrl) { image in
                    image.resizable()
                } placeholder: {
                    Image(.fashion)
                        .resizable()
                }
                .frame(width: 100, height: 100)
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                Image(.fashion) 
                    .resizable()
                    .frame(width: 80, height: 80)
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            Text(category.name)
                .font(.headline)
                .foregroundStyle(.black)
        }
    }
}


#Preview {
    CategoryItem(category: Category.dummy)
}
