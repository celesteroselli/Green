//**
//  ContentView.swift
//  GlobalHackathonApp
//
//  Created by Celeste Roselli on 9/12/23.
//
//

import SwiftUI
let FirstName = ""
struct ContentView: View {
    @State var shouldShowOnboarding: Bool = true
    var body: some View {
        
        HomePage()
        
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
