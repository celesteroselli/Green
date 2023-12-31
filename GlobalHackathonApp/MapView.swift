//
//  PointDashboard.swift
//  GlobalHackathonApp
//
//  Created by Celeste Roselli on 9/14/23.
//

import SwiftUI
import MapKit

//defines Place structure, with ID, name, coordinates, and address
//used to define "Green Sites" to be shown on Map
struct Place: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
    var address: String
}

struct MapView: View {
    
    //list of all "Green Sites" currently used
    //these are real sustainable businesses in NYC! Look them up!
    let annotations = [
        Place(name: "Zero Waste Daniel", coordinate: CLLocationCoordinate2D(latitude: 40.704260, longitude: -73.933610), address: "257 Varet St, Brooklyn, NY"),
        Place(name: "Planted", coordinate: CLLocationCoordinate2D(latitude: 40.680510, longitude: -73.994430), address: "333 Smith St, Brooklyn, NY"),
        Place(name: "4th Street Co-Op", coordinate: CLLocationCoordinate2D(latitude: 40.726530, longitude: -73.990870), address: "58 East 4th Street, New York, NY"),
        Place(name: "Magpie", coordinate: CLLocationCoordinate2D(latitude: 40.786190, longitude: -73.976520), address: "488 Amsterdam Ave, New York, NY 10024"),
        Place(name: "Baggu", coordinate: CLLocationCoordinate2D(latitude: 40.717480, longitude: -73.962790), address: "242 Wythe Avenue #4, Brooklyn, NY 11249")
    ]
    
    //Creates the region of the map automatically loaded (NYC)
    //In a production version of this app, with more cities participating in it, this would be replaced by user location
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    
    var body: some View {
        NavigationStack {
            VStack {
                //Shows map with Green Sites displayed
                Map(coordinateRegion: $region,
                    annotationItems: annotations
                ) { place in
                    //for each annotation, display a PlaceAnnotationView
                    MapAnnotation(coordinate: place.coordinate) {
                        PlaceAnnotationView(title: place.name, address: place.address)
                    }
                }
                
            }
            
            .ignoresSafeArea(.all)
            //Adds a toolbar to the map screen
        }.navigationTitle("Green Sites Near Me")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
    }
    
}


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
