//
//  MapView.swift
//  Places
//
//  Created by Bob Godwin Obi on 26.01.21.
//

import SwiftUI
import MapKit


struct MapView: View {
    @ObservedObject var viewModel: LocationsViewModel
    
    init(viewModel: LocationsViewModel) {
        self.viewModel = viewModel
    }
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
                                           span: MKCoordinateSpan(latitudeDelta: 35, longitudeDelta: 35))
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: viewModel.places) { location in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)) { makeAnnotationView(with: location)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }
    
    private func makeAnnotationView(with location: Location) -> some View {
        /// We wrap each annotationContent inside a NavigationLink
        /// So that when tapped it then links to that specific location
        NavigationLink(destination: LocationView(with: location)) {
        Image(location.country)
            .resizable()
            .cornerRadius(10)
            .frame(width: 80, height: 40)
            .shadow(radius: 3)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = LocationsViewModel(MockDataAPIService())
        MapView(viewModel: viewModel)
    }
}
