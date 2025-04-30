//
//  ListContentView+ToolBar.swift
//  SqoopDesignDemos
//
//  Created by Greem on 11/4/24.
//

import SwiftUI
import SqoopDesignSystem
import SQComponents

extension MusicPlaylistView {
    
    struct RemoveButton: View {
        
        @State private var isDeleteTriggered = false
        
        let isSelectionEmpty: Bool
        let isSelectionFull: Bool
        let deleteAction: () -> Void
        
        private var alertTitle: String {
            isSelectionFull ? "전체 곡은 삭제할 수 없어요" : "선택한 곡을 삭제하시겠어요?"
        }
        
        private var alertMessage: String {
            isSelectionFull ? "플레이리스트에는 최소 한 곡이 필요해요" : "플레이리스트에서 선택한 곡이 삭제됩니다"
        }
        
        var body: some View {
            SQFixedPositionRemoveButton {
                isDeleteTriggered.toggle()
            }
            .disabled(isSelectionEmpty)
            .alert(alertTitle, isPresented: $isDeleteTriggered) {
                if isSelectionFull {
                    Button("확인", role: .cancel) {}
                } else {
                    Button("삭제", role: .cancel) {}
                    Button("삭제", role: .destructive) { deleteAction() }
                    Button("취소", role: .cancel) { }
                }
            } message: {
                Text(alertMessage)
            }
        }
    }
}

extension MusicPlaylistView {
    var bottomToolBar: some View {
        Group {
            if self.oceans.isEmpty {
                SQPopUp(label: .init(icon: .info, title: "음악이 스쿱되지 않았어요!"), btnAction: {
                    
                }, btnTitle: {
                    "재검색하기"
                }, popUpDesc: {
                    "영상 내의 음악 정보를 찾기 어려운 플레이리스트입니다\n깊게 검색하면 시간이 조금 더 걸려요"
                })
                .padding(.all, 16)
            } else {
                if isEditing {
                    RemoveButton(
                        isSelectionEmpty: multiSelection.isEmpty,
                        isSelectionFull: self.oceans.count == self.multiSelection.count
                    ) {
                        var idxes = IndexSet()
                        for (idx, ocean) in self.oceans.enumerated() {
                            if self.multiSelection.contains(ocean.id) {
                                idxes.insert(idx)
                            }
                        }
                        withAnimation {
                            self.oceans.remove(atOffsets: idxes)
                        } completion: {
                            multiSelection.removeAll()
                        }
                    }
                    .disabled(self.oceans.count == self.multiSelection.count)
                    .ignoresSafeArea(.all,edges: .bottom)
                } else {
                    VStack(spacing: isExpanded ? 9 : 20) {
                        SQDisclosurePopUp(label: .init(icon: .info,
                                                       title: "플레이리스트가 다른가요?"),
                                          isExpanded: $isExpanded) {
                            print("isExpanded Tapped!!")
                        } btnTitle: {
                            "재검색하기"
                        } popUpDesc: {
                            "재검색 시, 더 정확한 플리를 얻을 수 있어요!"
                        }
                        .padding(.horizontal, 16)
                        
                        SQFixedPositionButton(
                            isActive: true,
                            buttonText: "Apple Music으로 보내기"
                        ) {
                            print("애플 뮤직으로 보내기!!")
                        }
                    }
                    .ignoresSafeArea(.all,edges: .bottom)
                }
            }
        }
    }
}
