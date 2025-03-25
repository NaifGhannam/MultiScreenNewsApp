import Foundation
import SwiftUI

class NewsViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let newsService = NewsService()
    private var currentPage = 1

    func fetchNews(category: String? = nil) {
        isLoading = true
        newsService.fetchNews(category: category, page: currentPage) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let articles):
                    self.articles.append(contentsOf: articles)
                case .failure(let error):
                    self.errorMessage = "Failed to load news: \(error.localizedDescription)"
                }
            }
        }
    }

    func loadMoreNews() {
        currentPage += 1
        fetchNews()
    }
}
