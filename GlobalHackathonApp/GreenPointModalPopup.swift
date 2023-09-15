//
//  openPageView.swift
//  GlobalHackathonApp
//
//  Created by Owen Daum on 9/15/23.
//

import SwiftUI
public  var greenPointsTally = 0
struct openPageView: View {
    var body: some View {
        Text( "\(greenPointsTally)")
        
    
    }
    struct ContentView: View {
        @State private var showSheet = false

        var body: some View {
            ZStack {
                Button("Present") {
                    showSheet.toggle()
                }
                .font(.largeTitle)
            
                if showSheet {
                    ZStack {
                        Button {
                            showSheet.toggle()
                        } label: {
                            Image(systemName: "xmark.circle")
                                .font(.largeTitle)
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                        .padding()
                    }
                    .background(.ultraThickMaterial)
                }
            }
        }
    }
}

#Preview {
    openPageView()
}
