//
//  MusicPlaylistView+ListView.swift
//  SqoopDesignDemos
//
//  Created by Greem on 11/4/24.
//

import SwiftUI
import SqoopDesignSystem
import SQComponents
extension MusicPlaylistView {

    var listContentView: some View {
        List(oceans, selection: $multiSelection) { ocean in
            SQMusiclistCell(item: ocean, playingItemID: self.musicID, title: ocean.name, artist: "",action: {}) { item in
                self.musicID = item?.id
                print("눌리긴 함! \(ocean.id)")
            }
        }
        .environment(\.editMode, $editMode)
        .tint(Color.textBrand)
        .foregroundStyle(Color.bgBlack)
        .preferredColorScheme(.dark)
        .listSectionSpacing(0)
        .listStyle(.plain).padding(.top, 24 + 96 + 8 + 34 + 8 + 20 + 40 - 16)
    }
}
