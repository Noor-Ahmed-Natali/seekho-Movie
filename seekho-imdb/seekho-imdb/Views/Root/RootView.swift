//
//  RootView.swift
//  seekho-imdb
//
//  Created by Noor Ahmed on 29/10/24.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        NavigationStack {
            HomePageView()
        }
        .tint(.gray)
    }
}

#Preview {
    RootView()
}
