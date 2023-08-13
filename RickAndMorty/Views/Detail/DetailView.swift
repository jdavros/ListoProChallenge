//
//  DetailView.swift
//  RickAndMorty
//
//  Created by José Dávalos Rosas on 06/08/23.
//

import SwiftUI

struct DetailView: View {

    let character: CharacterWithImage
    @State private var episodes = [String]()
    @ObservedObject private var viewModel: DetailViewModel

    var body: some View {
        VStack {
            DetailHeaderView(character: character)
            DetailInformationView(character: character)
            Text("detail_view_episodes")
                .font(.custom(Font.amasticBold, size: 25))
            List {
                ForEach(viewModel.episodesDetails) { episode in
                    HStack {
                        Text(episode.id)
                        Text(episode.name)
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.getEpisodesDetail()
        }
    }

    init(
        character: CharacterWithImage,
        viewModel: DetailViewModel? = nil
    ) {
        self.character = character
        self.viewModel = viewModel ?? DetailViewModel(episodeURLs: character.episodes)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let characterWithImage = CharacterWithImage(
            id: 1,
            name: "Rick",
            status: "Alive",
            species: "Human",
            type: "",
            gender: "Male",
            origin: ExtraInfo(name: "Earth (Replacement Dimension)", url: nil),
            location: ExtraInfo(name: "Earth (Replacement Dimension)", url: nil),
            image: Image.characterPlaceholder,
            episodes: [
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/2",
                "https://rickandmortyapi.com/api/episode/3",
                "https://rickandmortyapi.com/api/episode/4",
                "https://rickandmortyapi.com/api/episode/5"
            ]
        )
        Group {
            DetailView(
                character: characterWithImage,
                viewModel: DetailViewModel(
                    episodeURLs: characterWithImage.episodes,
                    service: MockCharacterService()
                )
            )
            .environment(\.locale, Locale(identifier: "en"))
            DetailView(
                character: characterWithImage,
                viewModel: DetailViewModel(
                    episodeURLs: characterWithImage.episodes,
                    service: MockCharacterService()
                )
            )
            .environment(\.locale, Locale(identifier: "es"))
        }
    }
}
