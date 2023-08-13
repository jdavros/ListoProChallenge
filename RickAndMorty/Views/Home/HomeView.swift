//
//  HomeView.swift
//  RickAndMorty
//
//  Created by José Dávalos Rosas on 29/07/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()

    var body: some View {
        NavigationView {
            if viewModel.loadingState == .loaded {
                HomeListView(viewModel: viewModel)
            } else {
                HomeLoadingScreenView(viewModel: viewModel)
            }
        }
        .animation(.linear(duration: 2.0).repeatForever(autoreverses: false), value: viewModel.startAnimation)
        .onAppear {
            viewModel.getCharactersList()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = HomeViewModel(service: MockCharacterService())
        Group {
            HomeView(viewModel: viewModel)
                .environment(\.locale, Locale(identifier: "en"))
                .onAppear {
                    viewModel.getCharactersList()
                }
            HomeView(viewModel: viewModel)
                .environment(\.locale, Locale(identifier: "es"))
                .onAppear {
                    viewModel.getCharactersList()
                }
        }
    }
}
