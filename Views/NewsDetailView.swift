//
//  NewsDetailView.swift
//  MultiScreenNewsApp
//
//  Created by Mac on 25/09/1446 AH.
//

import Foundation
import SwiftUI

struct NewsDetailView: View {
    let article: Article
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let imageUrl = article.urlToImage, let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { phase in
                        if let image = phase.image {
                            image.resizable()
                                .scaledToFit()
                        } else {
                            ProgressView()
                        }
                    }
                }
                
                Text(article.title)
                    .font(.title)
                    .padding(.top)

                if let description = article.description {
                    Text(description)
                        .padding(.top, 5)
                }
                
                Button("Read More") {
                    if let url = URL(string: article.url) {
                        UIApplication.shared.open(url)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
        }
    }
}
