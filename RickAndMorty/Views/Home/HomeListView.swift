//
//  HomeListView.swift
//  RickAndMorty
//
//  Created by José Dávalos Rosas on 12/08/23.
//

import SwiftUI

struct HomeListView: View {

    @StateObject var viewModel: HomeViewModel

    var body: some View {
        List {
            ForEach(viewModel.charactersList) { item in
                NavigationLink {
                    DetailView(character: item)
                } label: {
                    HStack {
                        item.image?
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
    }
}

struct HomeListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = HomeViewModel(
            networkService: MockCharacterService(),
            databaseService: MockDatabaseService()
        )
        HomeListView(viewModel: viewModel)
    }
}
