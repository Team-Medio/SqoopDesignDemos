//
//  ListContentView+NavigationBar.swift
//  SqoopDesignDemos
//
//  Created by Greem on 11/4/24.
//

import SwiftUI
import SqoopDesignSystem
import SQComponents

extension MusicPlaylistView {
    var navigationBar: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                Rectangle().fill(.clear).frame(height: 20)
                
                NavigationBar(editMode: $editMode,
                              isEditing: $isEditing,
                              isEditOccured : prevEditOceans.map(\.id) == oceans.map(\.id)) {
                    dismiss()
                } cancelAction: {
                    oceans = prevEditOceans
                    isEditing = false
                } editStartAction: {
                    prevEditOceans = oceans
                }
                
                SQPlaylistInfo(title: "[Playlist] 낭만 청춘 어쩌고",
                               channelName: "See Pearl",
                               thumbnailImageUrl: "").padding(.top, 24).padding(.horizontal, 16)
                SongListInfoLabel(songCount: oceans.count,
                                  isEditing: isEditing,
                                  isSelectedAll: multiSelection.count == oceans.count,
                                  isModifiedItemList: oceans.map(\.id) != originOcean.map(\.id),
                                  resetAction: {
                    withAnimation { self.oceans = originOcean }
                }, selectAll: {
                    oceans.map(\.id).forEach {  multiSelection.insert($0) }
                }, disableAll: {
                    multiSelection.removeAll()
                })
                
                .padding(.all, 16).padding(.vertical, -16).offset(y: 2)
                Spacer()
            }.frame(height: 24 + 96 + 8 + 34 + 8 + 20 + 40 - 16)
            Spacer()
        }
    }
}

extension MusicPlaylistView {
    struct NavigationBar: View {
        @Environment(\.dismiss) var dismiss
        @Binding var editMode: EditMode
        @Binding var isEditing: Bool
        let isEditOccured: Bool
        @State private var isBackTriggered = false
        @State private var isCancelTriggered = false
        let backAction: () -> Void
        let cancelAction: () -> Void
        let editStartAction: () -> Void
        
        var body: some View {
            SQNavigationBar(type: .editableLabel(title: "플레이리스트",
                                                 isEditing: isEditing,
                                                 backAction: leadingTapped,
                                                 editAction: trailingTapped))
            .onChange(of: isEditing) { oldValue, newValue in
                withAnimation { self.editMode = newValue ? .active : .inactive }
            }
            .alert("편집을 그만두시겠어요?",
                   isPresented: $isCancelTriggered){
                Button("취소",role: .cancel) { }
                Button("확인") { cancelAction() }
            } message: {
                Text("지금까지의 편집 사항이 모두 사라집니다")
            }
            .alert("작업을 중단하고 뒤로 가시겠어요?", isPresented: $isBackTriggered) {
                Button("취소",role: .cancel) { }
                Button("확인") { backAction() }
            } message: {
                Text("스쿱된 플레이리스트가 시작됩니다")
            }
        }
        
        
        func leadingTapped() {
            withAnimation {
                if isEditing {
                    if isEditOccured {
                        cancelAction()
                    } else {
                        isCancelTriggered = true
                    }
                } else {
                    isBackTriggered = true
                }
            }
        }
        
        func trailingTapped() {
            withAnimation {
                isEditing.toggle()
                if isEditing { editStartAction() }
            }
        }
    }
}
