//
//  ListContentView.swift
//  Temp
//
//  Created by Greem on 10/29/24.
//

import SwiftUI
import SqoopDesignSystem
import SQComponents

struct Ocean: Identifiable, Equatable {
    let name: String
    let id = UUID()
}

#if os(iOS)
let testOceans : [Ocean] = [
    Ocean(name: "Pacific"),
    .init(name: "Atlantic"),
    .init(name: "Indian"),
    .init(name: "Southern"),
    .init(name: "Arctic"),
]


struct MusicPlaylistView: View {
    @State var editMode: EditMode = .inactive
    @State var isEditing = false
//    var hello: Identifiable.ID = Ocean(name: "Pacific").id
    @State var multiSelection = Set<UUID>()
    
    let originOcean: [Ocean] = testOceans
    @State var oceans : [Ocean] = testOceans
    @State var prevEditOceans: [Ocean] = testOceans
    
    @Environment(\.dismiss) var dismiss
    @State var isExpanded: Bool = false
    @State var musicID: UUID? = nil
    var body: some View {
        ZStack(alignment:.bottom) {
            if oceans.isEmpty {
                
            } else {
                listContentView
            }
            navigationBar
            bottomToolBar
        }
        .ignoresSafeArea(.all, edges: oceans.isEmpty ? Edge.Set() : .bottom)
        .sqoopBackground()
        .toolbar(.hidden, for: .navigationBar)
    }
    //    private func onDelete(offsets: IndexSet) {
    //        items.remove(atOffsets: offsets)
    //    }
    //
    //    // 3.
    //    private func onMove(source: IndexSet, destination: Int) {
    //        items.move(fromOffsets: source, toOffset: destination)
    //    }
}

#endif
#Preview {
    ZStack {
        Color.black.ignoresSafeArea(.all)
#if os(iOS)
        MusicPlaylistView().loadSqoopFontSystem()
#endif
    }
}
