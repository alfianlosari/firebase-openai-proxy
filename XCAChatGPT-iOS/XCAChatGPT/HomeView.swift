//
//  HomeView.swift
//  XCAChatGPT
//
//  Created by Alfian Losari on 29/03/24.
//

import Foundation
import SwiftUI

struct HomeView: View {
    
    @StateObject var vm = ViewModel(api: ChatGPTAPI(tokenProvider: getAuthToken))
    @State var isShowingTokenizer = false
    @Binding var authState: AuthenticationState

    var body: some View {
        NavigationStack {
            ContentView(vm: vm)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        HStack {
                            Button("Clear") {
                                vm.clearMessages()
                            }
                            .disabled(vm.isInteractingWithChatGPT)
                            
                            Button("Logout", role: .destructive) {
                                authState.signout()
                            }
                            .foregroundStyle(Color.red)
                        }
                    }
                    
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Tokenizer") {
                            self.isShowingTokenizer = true
                        }
                        .disabled(vm.isInteractingWithChatGPT)
                    }
                }
        }
        .fullScreenCover(isPresented: $isShowingTokenizer) {
            NavigationTokenView()
        }
    }
}


struct NavigationTokenView: View {
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            TokenizerView()
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Close") {
                            dismiss()
                        }
                    }
                }
        }
        .interactiveDismissDisabled()
    }
}

