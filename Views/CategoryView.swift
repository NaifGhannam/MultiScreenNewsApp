import SwiftUI

struct CategoryView: View {
    let categories = ["Technology", "Sports", "Health"]
    @StateObject private var viewModel = NewsViewModel()
    @State private var selectedCategory = "Technology" 

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(viewModel.articles) { article in
                        NavigationLink(destination: NewsDetailView(article: article)) {
                            NewsRowView(article: article)
                        }
                    }

                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        Button("Load More") {
                            viewModel.loadMoreNews()
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }
            .navigationTitle("Category News")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu {
                        ForEach(categories, id: \.self) { category in
                            Button(category) {
                                selectedCategory = category
                                viewModel.articles = []
                                viewModel.fetchNews(category: category.lowercased())
                            }
                        }
                    } label: {
                        Text("Categories")
                    }
                }
            }
            .onAppear {
                if viewModel.articles.isEmpty {
                    viewModel.fetchNews(category: selectedCategory.lowercased())
                }
            }
        }
    }
}
