//
//  HomeView.swift
//  RickAndMorty
//
//  Created by José Dávalos Rosas on 29/07/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()

    var body: some View {
        NavigationView {
            if viewModel.loadingState != .idle {
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
                                    HStack(alignment: .top) {
                                        Text("home_view_name")
                                            .bold()
                                        Text(item.name)
                                    }
                                    HStack {
                                        Text("home_view_status")
                                            .bold()
                                        Text(item.status)
                                    }
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
                        .rotationEffect(Angle(degrees: viewModel.loadingState != .idle ? 360: 0))
                }
            }
        }
        .animation(.linear(duration: 2.0).repeatForever(autoreverses: true), value: viewModel.loadingState)
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
