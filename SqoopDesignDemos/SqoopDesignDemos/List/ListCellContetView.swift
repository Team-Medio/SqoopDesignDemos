//
//  ListCellContetView.swift
//  SqoopDesignDemos
//
//  Created by Greem on 11/3/24.
//

import SwiftUI
import SqoopDesignSystem
import SQComponents
struct ListCellContetView: View {
    @State var isPlaying: Bool = false
    let id = UUID()
    @State var playingItemID: UUID? = nil
    var body: some View {
        SQMusiclistCell(item: Ocean(name: ""), playingItemID: playingItemID, title: "SQMusicPlaylistCell", artist: "소라고동",action: {
            
        }) { item in
            print("눌리긴 함! \(id)")
            self.playingItemID = item?.id
        }.padding(.horizontal, 16)
    }
}
