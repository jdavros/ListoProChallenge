//
//  DetailInformationView.swift
//  RickAndMorty
//
//  Created by José Dávalos Rosas on 13/08/23.
//

import SwiftUI

struct DetailInformationView: View {
    let character: CharacterWithImage

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text("detail_view_status \(character.status)")
                    Text("detail_view_species \(character.species)")
                    Text("detail_view_origin \(character.origin.name)")
                }
                .frame(maxWidth: .infinity)
                VStack(alignment: .leading) {
                    Text("detail_view_gender \(character.gender)")
                    Text("detail_view_type \(character.type)")
                    Text("detail_view_location \(character.location.name)")
                }
                .frame(maxWidth: .infinity)
            }
            .font(.system(.footnote, design: .rounded))
        }
        .frame(maxWidth: .infinity, maxHeight: 80)
        .background(.secondary)
    }
}

struct DetailInformationView_Previews: PreviewProvider {
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
        DetailInformationView(character: characterWithImage)
    }
}
