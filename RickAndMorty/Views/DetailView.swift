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

    var body: some View {
        VStack {
            VStack {
                character.image
                    .resizable()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .aspectRatio(contentMode: .fit)
                Text("detail_view_title \(character.name)")
                    .font(.custom(Font.amasticBold, size: 30))
            }
            .frame(maxWidth: .infinity, maxHeight: 250)
            .background(Color(UIColor.systemBackground))

            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("detail_view_status \(character.status)")
                        Text("detail_view_species \(character.status)")
                        Text("detail_view_type \(character.status)")
                    }
                    .frame(maxWidth: .infinity)
                    VStack(alignment: .leading) {
                        Text("detail_view_gender \(character.status)")
                        Text("detail_view_origin \(character.status)")
                        Text("detail_view_location \(character.status)")
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 140)
            .background(.secondary)
            Text("detail_view_episodes")
                .font(.custom(Font.amasticBold, size: 30))
            List {
                ForEach(character.name) { character in
                    HStack {
                        Text(character)
                        Text("Lorem ipsum dolor")
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    init(character: CharacterWithImage) {
        self.character = character
        self.episodes = episodes
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let characterWithImage = CharacterWithImage(
            id: 1,
            name: "Rick",
            status: "Alive",
            image: Image.characterPlaceholder
        )
        Group {
            DetailView(character: characterWithImage)
                .environment(\.locale, Locale(identifier: "en"))
            DetailView(character: characterWithImage)
                .environment(\.locale, Locale(identifier: "es"))
        }
    }
}
