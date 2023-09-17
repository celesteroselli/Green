//
//  PlaceAnnotationView.swift
//  GlobalHackathonApp
//
//  Created by Celeste Roselli on 9/15/23.
//

import SwiftUI

struct PlaceAnnotationView: View {
    @State private var showTitle = true
    
    //gets title and address when called for each location
    let title: String
    let address: String
    
    var body: some View {
        //shows title, then map pin image, then address underneath
        VStack(spacing: 0) {
            Text(title)
                .font(.callout)
                .padding(5)
                .background(Color(.white))
                .cornerRadius(10)
                .opacity(showTitle ? 0 : 1)
            
            Image(systemName: "mappin.circle.fill")
                .font(.title)
                .foregroundColor(.green)
            
            Image(systemName: "arrowtriangle.down.fill")
                .font(.caption)
                .foregroundColor(.green)
                .offset(x: 0, y: -5)
            
            Text(address)
                .font(.callout)
                .padding(5)
                .background(Color(.white))
                .cornerRadius(10)
                .opacity(showTitle ? 0 : 1)
        }
        //on tap, toggles tile and address
        .onTapGesture {
            withAnimation(.easeInOut) {
                showTitle.toggle()
            }
        }
    }
}
