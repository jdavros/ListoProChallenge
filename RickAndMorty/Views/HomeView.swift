//
//  HomeView.swift
//  RickAndMorty
//
//  Created by José Dávalos Rosas on 29/07/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel(client: URLSessionHttpClient())

    var body: some View {
        NavigationView {
            if viewModel.loadingState == .loaded {
                List {
                    ForEach(viewModel.charactersList) { item in
                        NavigationLink {
                            DetailView(character: item)
                        } label: {
                            HStack {
                                item.image
                                    .resizable()
                                    .clipShape(Circle())
                                    .frame(width: 80, height: 80)
                                VStack(alignment: .leading) {
                                    Text("home_view_name \(item.name)")
                                }
                            }
                        }
                    }
                }
                .navigationTitle("home_view_title")
            } else {
                VStack {
                    Text("home_view_loading")
                        .font(.system(size: 28, weight: .semibold, design: .monospaced))
                    Image.characterPlaceholder
                        .clipShape(Circle())
                        .frame(width: 400, height: 400)
                        .rotationEffect(Angle(degrees: viewModel.startAnimation ? -360: 0))
                }
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
        let viewModel = HomeViewModel()
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
