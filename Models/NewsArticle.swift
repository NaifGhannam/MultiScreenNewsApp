
import Foundation

struct Article: Identifiable, Codable {
    let id = UUID()
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
}

struct NewsResponse: Codable {
    let articles: [Article]
}
