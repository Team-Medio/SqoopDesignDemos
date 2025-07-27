//
//  ContentView.swift
//  Temp
//
//  Created by Greem on 10/28/24.
//

import SwiftUI
import SQComponents

struct AllButtons:View {
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                SQButton(text: "버튼명") { }
                SQCancelButton(title: "취소맨~",
                               symbol: .cancel, action: {})
                SQFixedPositionButton(
                    isActive: true,
                    buttonText: "buttonText",
                    action: {}
                )
            }
        }
    }
}
struct ContentView: View {
    
    @Environment(\.openURL) private var openURL
    
    @State private var isActive: Bool = false
    @State private var progress: Double = 0.0
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    buttons
                    NavigationLink("SQProgress Bar") {
                        SQProgressBar(value: $progress)
                            .padding(.horizontal, 16)
                            .sqoopBackground()
                            .navigationTitle("0.0 ~ 1.0 까지")
                            .onAppear() {
                                Task {
                                    try await Task.sleep(for: .seconds(1))
                                    await MainActor.run {
                                        withAnimation { progress = 1 }
                                    }
                                }
                            }
                    }
                    DisclosureGroup("ToolBars") {
                        NavigationLink("SQNavigationBars"){
                            ScrollView {
                                VStack(spacing: 20) {
                                    SQNavigationBar(type: .back(backAction: {}))
                                    SQNavigationBar(type: .backLabel(title: "backLabel", backAction: {}))
                                    SQNavigationBar(type: .cancel(cancelAction: { }))
                                    SQNavigationBar(type: .cancelLabel(title: "cancelLabel", cancelAction: {}))
                                    SQNavigationBar(type: .label(title: "label"))
                                    SQNavigationBar(type: .editableLabel(title: "editLabel", isEditing: false, backAction: {}, editAction: {
                                        
                                    }))
                                    SQNavigationBar(type: .custom(title: "커스텀 네비", leadingView: {
                                        Button(action: {}) { Text("LeadingBtn") }
                                    }, trailingView: {
                                        Button(action: {}) { Text("TrailingBtn") }
                                    }))
                                }
                            }
                        }
                    }
                    
                    NavigationLink("SQPaginationDot") {
                        VStack {
                            SQPaginationDot(pageCount: 3, currentPage: 0)
                            SQPaginationDot(pageCount: 3, currentPage: 1)
                            SQPaginationDot(pageCount: 3, currentPage: 2)
                        }
                    }
                    
                    NavigationLink("SQToastMessage") {
                        VStack {
                            SQToastMessage(
                                leadingIcon: .channelName,
                                componentType: .onlyMainDescription(mainDescription: "메인 설명")
                            )
                            
                            SQToastMessage(
                                leadingIcon: .channelName,
                                componentType: .mainDescriptionWithSubDescription(
                                    mainDescription: "메인 설명",
                                    subDescription: "서브 설명"
                                )
                            )
                            
                            SQToastMessage(
                                leadingIcon: .channelName,
                                componentType: .mainDescriptionWithSubDescription(
                                    mainDescription: "메인 설명",
                                    subDescription: "서브 설명",
                                    subDescriptionChevronAction: {
                                        print("SQToastMessage Sub Action")
                                    }
                                )
                            )
                        }
                    }
                    
                    NavigationLink("SQCircularLoadig") {
                        ZStack {
                            Color.bgBlack.ignoresSafeArea()
                            SQButton(text: "테스트 버튼") {
                                print("이 버튼은 눌려서는 안됩니다.")
                            }
                        }
                        .circularLoading(true)
                    }
                    
                    NavigationLink("SQSymbol") {
                        VStack {
                            SQSymbol(symbol: .alert)
                            SQSymbol(symbol: .channelName)
                            SQSymbol(symbol: .link)
                        }
                    }
                    
                    NavigationLink("SQAnimation") {
                        VStack {
                            SQAnimation(.inSqoop)
                            SQAnimation(.reSqoop)
                        }
                    }
                } header: {
                    Text("SQ Custom Components")
                }
                
                Section {
                    
                    NavigationLink("SQPlaylistInfo") {
                        SQPlaylistInfo(title: "유튜브 제목", channelName: "채널명", thumbnailImageUrl: "").padding(.horizontal, 16)
                    }
                    
                    NavigationLink("SQThumbnailBox") {
                        ScrollView {
                            VStack(spacing: 20) {
                                SQThumbnailBox(
                                    playlistName: "플리 이름",
                                    channelName: "채널명",
                                    thumbnailInfoType: .length(600),
                                    originalUrlString: "",
                                    thumbnailImageUrlString: "",
                                    thumbnailBoxTapAction: {
                                        openURL(URL(string: "https://www.youtube.com/results?search_query=%ED%94%8C%EB%A0%88%EC%9D%B4%EB%A6%AC%EC%8A%A4%ED%8A%B8")!)
                                    }
                                )
                                
                                SQThumbnailBox(
                                    playlistName: "플리 이름",
                                    channelName: "채널명",
                                    thumbnailInfoType: .songs(30),
                                    originalUrlString: "",
                                    thumbnailImageUrlString: "",
                                    thumbnailBoxTapAction: {
                                        openURL(URL(string: "https://www.youtube.com/results?search_query=%ED%94%8C%EB%A0%88%EC%9D%B4%EB%A6%AC%EC%8A%A4%ED%8A%B8")!)
                                    }
                                )
                            }
                            .padding(.horizontal, 16)
                            .navigationTitle("SQThumbnailBox")
                        }
                    }
                    
                    PopUps()
                    
                    DisclosureGroup("Custom List") {
                        
                        NavigationLink("MusicListView") {
#if os(iOS)
                            MusicPlaylistView().toolbar(.hidden, for: .navigationBar)
                            #else
                            Text("Hello world").sqoopBackground()
#endif
                        }
                        
                        NavigationLink("SQMusicListCell") {
                            ListCellContetView()
                        }
                        
//                        NavigationLink("SQSection") {
//                            SQSection(
//                                title: "Section Title",
//                                content: {
//                                    SQButtonListCell(
//                                        title: "SQButtonListCell",
//                                        action: {},
//                                        isOn: .constant(true)
//                                    )
//                                    
//                                    SQToggleListCell(
//                                        title: "SQToggleListCell",
//                                        isOn: .constant(true)
//                                    )
//                                }
//                            )
//                        }
//                        
//                        NavigationLink("SQButtonListCell") {
//                            SQButtonListCell(
//                                title: "SQButtonListCell",
//                                action: {},
//                                isOn: .constant(true)
//                            )
//                        }
                        
                        NavigationLink("SQToggleListCell") {
                            SQToggleListCell(
                                title: "SQToggleListCell",
                                isOn: .constant(true)
                            )
                        }
                    }
                     
                    DisclosureGroup("Custom Writing") {
                        NavigationLink("SQExtractingWritingSet") {
                            SQExtractingWritingSet(minutes: 3)
                        }
                        NavigationLink("SQExtractingWritingSet") {
                            SQMainWriting(mainDesc: "안녕하세요", mainDesc2: "안녕하세요", subDesc: "안녕하세요")
                        }
                    }
                     
                } header: {
                    Text("SQ Custom Views")
                }
                
                Section {
                    DisclosureGroup("RecommendPlaylistDetail") {
                        NavigationLink("ChannelInfoView") {
                            SQChannelInfoView(
                                name: "침착맨",
                                thumbnailURLString: "",
                                subscriberCount: 2000,
                                channelURLString: "") {
                                    print("Hello wrold")
                                }
                        }
                        NavigationLink("PlaylistCommentCellView") {

                            SQPlaylistCommentCellView(
                                userThumbnailURLString: "",
                                userName: "한톨톨",
                                likesCount: 31344356,
                                comment: "안녕하세요"
                            )
                        }
                    }

                } header: {
                    Text("Sqoop Project Component")
                }
            }.navigationTitle("Sqoop Components")
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea(.all)
        ContentView().padding(.horizontal, 16)
    }.background(.black).ignoresSafeArea(.all)
        .loadSqoopFontSystem()
        .colorScheme(.dark)
}
