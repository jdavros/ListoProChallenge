//
//  DetailView.swift
//  RickAndMorty
//
//  Created by José Dávalos Rosas on 06/08/23.
//

import SwiftUI

struct DetailView: View {

    let character: CharacterWithImage

    var body: some View {
        VStack {
            character.image
                .frame(width: 200, height: 200)
            Text("detail_view_title \(character.name)")
                .font(.custom(Font.amasticBold, size: 20))
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let characterWithImage = CharacterWithImage(
            id: 1,
            name: "Rick",
            status: "Alive",
            image: Image.detailPlaceholder
        )
        DetailView(character: characterWithImage)
    }
}
