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
        Text("MapView")
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = LocationsViewModel(MockDataAPIService())
        MapView(viewModel: viewModel)
    }
}
