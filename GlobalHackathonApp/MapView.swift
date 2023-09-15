//
//  PointDashboard.swift
//  GlobalHackathonApp
//
//  Created by Celeste Roselli on 9/14/23.
//

import SwiftUI
import MapKit

struct Site: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D()
}

struct MapView: View {
    
    let annotations = [
    Site(name: "Zero Waste Daniel", coordinate: CLLocationCoordinate2D(latitude: 40.704260, longitude: -73.933610))
    ]
    
    @State private var region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060),
                span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
            )
    
    var body: some View {
            VStack {
                Map(coordinateRegion: $region, annotationItems: annotations) {
                    MapPin(coordinate: $0.coordinate)
                }
                }
                    .ignoresSafeArea(.all)
            }
        }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
