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
        VStack {
          
            
            Image(systemName: "leaf.circle.fill")
            
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world! This is on GitHub! And Liam can commit to it!")
        }
        .padding()
    }
    
    //funcaddedforcompliance
    func NavigationLink(destination: ScannerView) {
       //putsomestuffhere
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
