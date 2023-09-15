//
//  PointDashboard.swift
//  GlobalHackathonApp
//
//  Created by Celeste Roselli on 9/14/23.
//

import SwiftUI
import MapKit

struct Place: Identifiable {
  let id = UUID()
  var name: String
  var coordinate: CLLocationCoordinate2D
    var address: String
}

struct MapView: View {
    
    let annotations = [
    Place(name: "Zero Waste Daniel", coordinate: CLLocationCoordinate2D(latitude: 40.704260, longitude: -73.933610), address: "65 Asheworth"),
    Place(name: "Planted", coordinate: CLLocationCoordinate2D(latitude: 40.680510, longitude: -73.994430), address: "65 Asheworth")
    ]
    
    @State private var region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060),
                span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
            )
    
    var body: some View {
            VStack {
                Map(coordinateRegion: $region,
                       annotationItems: annotations
                   ) { place in
                     MapAnnotation(coordinate: place.coordinate) {
                         PlaceAnnotationView(title: place.name, address: place.address)
                     }
                   }

                }
                    .ignoresSafeArea(.all)
            }
        }

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
