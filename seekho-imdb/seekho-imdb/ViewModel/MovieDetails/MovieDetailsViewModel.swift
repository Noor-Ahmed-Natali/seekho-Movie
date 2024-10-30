//
//  MovieDetailsViewModel.swift
//  seekho-imdb
//
//  Created by Noor Ahmed on 30/10/24.
//

import Foundation

class MovieDetailsViewModel: ObservableObject {
    var id: Int
    @Published var movieDetails: MovieDetailsModel? = nil
    init(movieID: Int) {
        self.id = movieID
    }
}

extension MovieDetailsViewModel {
    func fetchMovieDetails() async {
        let url: String = "https://api.themoviedb.org/3/movie/"+"\(id)"
        let result = await APIManager.shared.baseRequest(url: url, Type: MovieDetailsModel.self)
        switch result {
        case .success(let success):
            DispatchQueue.main.async {
                self.movieDetails = success
            }
        case .failure(let failure):
            print(failure.localizedDescription)
        }
    }
}
//
//import Foundation
//
//let url = URL(string: "")!
//var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
//let queryItems: [URLQueryItem] = [
//  URLQueryItem(name: "language", value: "en-US"),
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
