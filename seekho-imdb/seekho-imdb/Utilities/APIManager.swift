//
//  APIManager.swift
//  seekho-imdb
//
//  Created by Noor Ahmed on 30/10/24.
//

import Foundation

class APIManager {
    static let shared: APIManager = .init()
    private var headers: [String: String] = [:]
    
    private init() {
        self.headers = ["accept": "application/json",
                        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjOTllNjEwZGM3OWUzYmU1ODc0YzM3YzFiYjE5MmJhMiIsIm5iZiI6MTczMDE4NzUwNC4yNjgxNDIsInN1YiI6IjY3MjA4ZjA0NDU0MmUzNzFmZTBiMmNmYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.X3OjMTBTcUBO5ygSqd3Yz9z_DinTs5DDb9MvwvmOm4M"
        ]
    }
    
    func baseRequest<T: Codable>(url: String, method: String = "GET",
                     queryParams: String? = nil, header: [String: String]? = nil,
                                 Type: T.Type) async -> Result<T?, APIErrors> {
        var url: String = url
        if let queryParams = queryParams {
            url = url+queryParams
        }
        guard let url = URL(string: url) else { return .failure(.invalidURL) }
        if let header = header {
            for (key, value) in header {
                self.headers[key] = value
            }
        }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            let decodedModel = try JSONDecoder().decode(T.self, from: data)
            return .success(decodedModel)
        } catch {
            return .failure(.somethingWentWrong)
        }
    }
}

//let url = URL(string: "https://api.themoviedb.org/3/movie/popular")!
//var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
//let queryItems: [URLQueryItem] = [
//  URLQueryItem(name: "language", value: "en-US"),
//  URLQueryItem(name: "page", value: "1"),
//]
//components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
//
//var request = URLRequest(url: components.url!)
//request.httpMethod = "GET"
//request.timeoutInterval = 10
//request.allHTTPHeaderFields = [
//  "accept": "application/json",
//  "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjOTllNjEwZGM3OWUzYmU1ODc0YzM3YzFiYjE5MmJhMiIsIm5iZiI6MTczMDE4NzUwNC4yNjgxNDIsInN1YiI6IjY3MjA4ZjA0NDU0MmUzNzFmZTBiMmNmYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.X3OjMTBTcUBO5ygSqd3Yz9z_DinTs5DDb9MvwvmOm4M"
//]
//
//let (data, _) = try await URLSession.shared.data(for: request)
//print(String(decoding: data, as: UTF8.self))
