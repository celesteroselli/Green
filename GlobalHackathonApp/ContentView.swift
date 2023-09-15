//**
//  ContentView.swift
//  GlobalHackathonApp
//
//  Created by Celeste Roselli on 9/12/23.
//
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "leaf.circle.fill")
            
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world! This is on GitHub! And Liam can commit to it!")
        }
        .padding()
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
