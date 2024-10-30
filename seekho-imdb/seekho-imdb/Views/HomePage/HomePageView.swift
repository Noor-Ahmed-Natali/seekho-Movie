//
//  HomePageView.swift
//  seekho-imdb
//
//  Created by Noor Ahmed on 29/10/24.
//

import SwiftUI

struct HomePageView: View {
    @StateObject var viewModel: HomePageViewModel = .init()
    private let columns = [GridItem(.flexible()),
                           GridItem(.flexible())]
    @State var selectedMovieID: Int? = nil
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(viewModel.movies, id: \.id) { movie in
                    collectionCellView(data: movie)
                        .onTapGesture {
                            selectedMovieID = movie.id
                        }
                }
            }
            .padding()
            .navigationDestination(item: $selectedMovieID) { id in
                MovieDetailsView(viewModel: .init(movieID: id))
            }
        }
        .scrollIndicators(.hidden)
        .task {
            await viewModel.fetchMovies()
        }
    }
    
    func collectionCellView(data: MovieModel) -> some View {
        VStack(spacing: 12) {
            asyncImageView(url: URL(string: "https://picsum.photos/id/12/600")!)
            Text(data.title ?? "")
                .bold()
                .multilineTextAlignment(.leading)
                .lineLimit(2, reservesSpace: true)
                .minimumScaleFactor(0.7)
            Text("Duration :- 5:56")
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
            Group {
                Text("Rating :- ") +
                Text(String(format: "%.1f", data.voteAverage ?? 0))
            }
            .font(.caption)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(12)
        .background(Color.secondary.opacity(0.1).shadow(radius: 4))
        .cornerRadius(24)
    }
    
    func asyncImageView(url: URL) -> some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image.resizable()
                    .frame(width: 150, height: 150)
                    .aspectRatio(contentMode: .fill)
                    .clipped()
            case .failure:
                Image(systemName: "photo")
            @unknown default:
                // Since the AsyncImagePhase enum isn't frozen,
                // we need to add this currently unused fallback
                // to handle any new cases that might be added
                // in the future:
                EmptyView()
            }
        }
        .cornerRadius(12)
    }
}

#Preview {
    HomePageView()
}
