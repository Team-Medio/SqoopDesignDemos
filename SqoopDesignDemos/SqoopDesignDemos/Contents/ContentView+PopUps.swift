//
//  ContentView+PopUps.swift
//  SqoopDesignDemos
//
//  Created by Greem on 10/31/24.
//

import SwiftUI
import SQComponents
extension ContentView {
    struct PopUps: View {
        @State var isExpanded: Bool = false
        var body: some View {
            DisclosureGroup("Custom PopUp") {
                NavigationLink("SQDisclosurePopUp"){
                    VStack {
                        Spacer()
                        SQDisclosurePopUp(label: .init(icon: .alert, title: "경고문"), isExpanded: $isExpanded){
                            
                        } btnTitle: {
                            "버튼명"
                        } popUpDesc: {
                            "여기 팝업\n잘 못 된 것 입력"
                        }.padding(.bottom,20).padding(.horizontal,16)
                    }.background(.white)
                }
                NavigationLink("SQPopUp") {
                    VStack {
                        Spacer()
                        SQPopUp(label: .init(icon: .alert, title: "경고문"),
                                button: .init(title: "버튼명", action: { }),
                                popUpDesc: "여기에 그냥 텍스트만 입력\n사용자 선택").padding(.bottom,20).padding(.horizontal,16)
                    }
                }
            }
        }
    }
}
