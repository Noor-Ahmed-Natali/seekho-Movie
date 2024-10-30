//
//  MovieDetailsView.swift
//  seekho-imdb
//
//  Created by Noor Ahmed on 30/10/24.
//

import SwiftUI

struct MovieDetailsView: View {
    @ObservedObject var viewModel: MovieDetailsViewModel
    var body: some View {
        VStack {
            Text("\(viewModel.movieDetails?.title ?? "")")
        }
        .task {
            await viewModel.fetchMovieDetails()
        }
    }
}

#Preview {
    MovieDetailsView(viewModel: .init(movieID: 1))
}
