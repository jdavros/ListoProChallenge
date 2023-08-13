//
//  DetailHeaderView.swift
//  RickAndMorty
//
//  Created by José Dávalos Rosas on 13/08/23.
//

import SwiftUI

struct DetailHeaderView: View {
    let character: CharacterWithImage

    var body: some View {
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
    }
}

struct DetailHeaderView_Previews: PreviewProvider {
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
        DetailHeaderView(character: characterWithImage)
    }
}
