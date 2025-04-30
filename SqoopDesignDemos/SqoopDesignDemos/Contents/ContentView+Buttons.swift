//
//  ContentView+Buttons.swift
//  SqoopDesignDemos
//
//  Created by Greem on 10/31/24.
//

import SwiftUI
import SQComponents
import SqoopDesignSystem
extension ContentView {
    
    var buttons: some View {
        DisclosureGroup("Buttons") {
            NavigationLink("All Buttons") {
                AllButtons()
            }
            NavigationLink("SQAccentButton") {
                SQAccentButton(text: "SQAccentButton") { }
            }
            NavigationLink("SQButton") {
                SQButton(text: "버튼명") { }
            }
            NavigationLink("SQCancelButton") {
                SQCancelButton(title: "취소맨~",
                               symbol: .cancel, action: {})
            }
            NavigationLink("SQFixedPositionButton") {
                VStack(spacing: 16) {
                    SQFixedPositionButton(isActive: false, buttonText: "buttonText", action: {})
                    SQFixedPositionButton(isActive: true, buttonText: "buttonText", action: {})
                }
            }
            NavigationLink("SQFixedPositionRemoveButton") {
                SQFixedPositionRemoveButton(action: {})
            }
            NavigationLink("SQMainButton") {
                VStack(spacing: 16) {
                    SQMainButton(buttonText: "buttonText", isActive: false, action: { })
                    SQMainButton(buttonText: "buttonText", isActive: true, action: { })
                }.padding(.horizontal, 16).navigationTitle("높이가 56인 기본 버튼")
            }
            NavigationLink("SQSecondButton") {
                VStack(spacing: 16) {
                    SQSecondButton(buttonText: "text!!", isActive: true) { }
                    SQSecondButton(buttonText: "text2!", isActive: false, action: {})
                }.padding(.horizontal, 16).navigationTitle("높이가 44인 기본 버튼")
            }
            NavigationLink("SQPopUpButton") {
                VStack(spacing: 16) {
                    SQPopUp(label: .init(icon: .alert, title: "경고문!")) { print("hello world")
                    } btnTitle: {
                        "이게 될 것 같니?"
                    } popUpDesc: {
                        "조금 문제가 있는 것\n2번친구 \n3번 친구"
                    }
                }.padding(.horizontal, 16)
            }
            
        }
    }
}
