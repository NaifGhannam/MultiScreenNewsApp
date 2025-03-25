import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = NewsViewModel()
    @Environment(\.colorScheme) var colorScheme
    @State private var isDarkMode = false
    @State private var selectedCategory = "Technology"
    private let categories = ["Technology", "Sports", "Health"]

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
                            .progressViewStyle(CircularProgressViewStyle())
                            .scaleEffect(1.5)
                            .frame(maxWidth: .infinity, alignment: .center)
                    } else {
                        Button("Load More") {
                            viewModel.loadMoreNews()
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }
            .navigationTitle("Latest News")
            .foregroundColor(colorScheme == .dark ? Color.white : Color.primary)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu {
                        Picker("Select Category", selection: $selectedCategory) {
                            ForEach(categories, id: \.self) { category in
                                Text(category).tag(category)
                            }
                        }
                        .pickerStyle(InlinePickerStyle())
                    } label: {
                        Label(selectedCategory, systemImage: "line.3.horizontal.decrease.circle")
                    }
                    .onChange(of: selectedCategory) { category in
                        viewModel.articles = []
                        viewModel.fetchNews(category: category.lowercased())
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isDarkMode.toggle()
                        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
                    }) {
                        Label("Dark Mode", systemImage: isDarkMode ? "moon.fill" : "sun.max.fill")
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
