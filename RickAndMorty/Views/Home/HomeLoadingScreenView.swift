//
//  HomeLoadingScreenView.swift
//  RickAndMorty
//
//  Created by José Dávalos Rosas on 12/08/23.
//

import SwiftUI

struct HomeLoadingScreenView: View {

    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
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
