import Foundation
import Alamofire

class NewsService {
    private let apiKey = "5ef4170b3ef345949f2a8a78e9c270ed"
    private let baseUrl = "https://newsapi.org/v2/top-headlines"
    
    func fetchNews(category: String? = nil, page: Int = 1, pageSize: Int = 10, completion: @escaping (Result<[Article], Error>) -> Void) {
        var parameters: [String: String] = [
            "apiKey": apiKey,
            "country": "us",
            "pageSize": "\(pageSize)",
            "page": "\(page)"
        ]

        if let category = category {
            parameters["category"] = category
        }

        AF.request(baseUrl, parameters: parameters)
            .validate()
            .responseDecodable(of: NewsResponse.self) { response in
                switch response.result {
                case .success(let newsResponse):
                    completion(.success(newsResponse.articles))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
