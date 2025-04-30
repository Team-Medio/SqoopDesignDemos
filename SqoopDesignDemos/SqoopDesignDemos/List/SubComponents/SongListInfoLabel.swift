//
//  SongListInfoLabel.swift
//  SqoopDesignDemos
//
//  Created by Greem on 11/4/24.
//

import SwiftUI
import SqoopDesignSystem

struct SongListInfoLabel: View {
    
    @State private var resetTriggered:Bool = false
    
    let songCount: Int
    let isEditing: Bool
    let isSelectedAll: Bool
    let isModifiedItemList: Bool
    let resetAction: () -> Void
    let selectAll: () -> Void
    let disableAll: ()-> Void
    
    var body: some View {
        HStack {
            Text("총 \(songCount) 곡")
                .fontWithLineHeight(.title01(weight: .regular))
                .foregroundStyle(Color.textPrimary)
            
            Spacer()
            
            Button {
                if isEditing {
                    if isSelectedAll {
                        disableAll()
                    } else {
                        selectAll()
                    }
                } else {
                    if isModifiedItemList {
                        resetTriggered = true
                    }
                    // resetAction()
                }
            } label: {
                HStack(spacing: 5) {
                    Image(symbol: getSymbol)
                        .font(.system(size: 15))
                    Text(getInfoString).font(.body01(.regular))
                }
                .foregroundStyle(Color.textPrimary)
            }
            .animation(nil, value: isEditing)
        }
        .frame(height: 34)
        .alert("초기화 하시겠어요?", isPresented: $resetTriggered) {
            Button("취소",role: .cancel) { }
            Button("확인") { resetAction() }
        } message: {
            Text("플레이리스트가 처음 상태로 되돌아갑니다")
        }
    }
    
    private var getSymbol: SFSymbol {
        isEditing ? (isSelectedAll ? .selectAll : .selectNone) : .reset
    }
    
    private var getInfoString: String {
        isEditing ? (isSelectedAll ? "전체 해제" : "전체 선택") : "초기화"
    }
}
