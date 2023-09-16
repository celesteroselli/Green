//
//  SettingsView.swift
//  GlobalHackathonApp
//
//  Created by Celeste Roselli on 9/16/23.
//

import SwiftUI

struct SettingsView: View {
    @Binding var name: String
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField(name, text: $name)
                } header: {
                    Text("Name")
                }
            }
        }.navigationTitle("Settings")
    }
}

//struct SettingsView_Previews: PreviewProvider {
 //   static var previews: some View {
  //      SettingsView()
  //  }
//}
