//
//  HomePageViewModel.swift
//  seekho-imdb
//
//  Created by Noor Ahmed on 30/10/24.
//

import Foundation

class HomePageViewModel: ObservableObject {
    var currentPage: Int = 0
    var totalPages: Int = 0
    @Published var movies: [MovieModel] = []
}

// MARK: APIs
extension HomePageViewModel {
    
    func fetchMovies() async {
        let result = await APIManager.shared.baseRequest(url: "https://api.themoviedb.org/3/movie/popular",
                                                         queryParams: "?language=en-US&page=1",
                                                         Type
                                                         : MovieListModel.self)
        switch result {
        case .success(let success):
            self.currentPage = success?.page ?? 0
            self.totalPages = success?.totalPages ?? 0
            DispatchQueue.main.async {
                self.movies = success?.results ?? []
            }
        case .failure(let failure):
            print(failure.localizedDescription)
        }
    }
}
