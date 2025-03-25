import SwiftUI

struct NewsRowView: View {
    let article: Article
    
    var body: some View {
        HStack {
            if let imageUrl = article.urlToImage, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { phase in
                    if let image = phase.image {
                        image.resizable()
                            .frame(width: 80, height: 80)
                            .cornerRadius(8)
                    } else {
                        ProgressView()
                    }
                }
            }
            
            VStack(alignment: .leading) {
                Text(article.title)
                    .font(.headline)
                    .lineLimit(2)
                
                if let description = article.description {
                    Text(description)
                        .font(.subheadline)
                        .lineLimit(2)
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(5)
    }
}
