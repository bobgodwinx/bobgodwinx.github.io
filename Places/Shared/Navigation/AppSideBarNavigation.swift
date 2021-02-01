//
//  AppSideBarNavigation.swift
//  Places
//
//  Created by Bob Godwin Obi on 26.01.21.
//

import SwiftUI

struct AppSideBarNavigation: View {
    @ObservedObject var locationsViewModel: LocationsViewModel
    @ObservedObject var imageGalleryViewModel: ImageGalleryViewModel
    @ObservedObject var tipsViewModel: TipsViewModel
    
    init(_ locationsViewModel: LocationsViewModel,
         _ imageGalleryViewModel: ImageGalleryViewModel,
         _ tipsViewModel: TipsViewModel) {
        self.locationsViewModel = locationsViewModel
        self.imageGalleryViewModel = imageGalleryViewModel
        self.tipsViewModel = tipsViewModel
    }
    
    @State private var selection: Set<Navigation.Item> = [.location]
    
    var sideBar: some View {
        List(selection: $selection) {
            NavigationLink(destination: LocationView(with: locationsViewModel.primary)) {
                Label("Discover", systemImage: "airplane.circle.fill")
                    .tag(Navigation.Item.location)
            }
            
            NavigationLink(destination: MapView()) {
                Label("Map", systemImage: "map.fill")
                    .tag(Navigation.Item.map)
            }
            
            NavigationLink(destination: TipsView(viewModel: tipsViewModel)) {
                Label("Tips", systemImage: "list.bullet")
                    .tag(Navigation.Item.tips)
            }
            
            NavigationLink(destination: GalleryView(viewModel: imageGalleryViewModel)
                            .onAppear(perform: imageGalleryViewModel.bind)) {
                Label("Gallery", systemImage: "rectangle.3.offgrid")
                    .tag(Navigation.Item.gallery)
            }
        }
        .navigationTitle("Places")
        .listStyle(SidebarListStyle())
        
    }
    
    var body: some View {
        NavigationView {
            sideBar
            LocationView(with: locationsViewModel.primary)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct AppSideBarNavigation_Previews: PreviewProvider {
    static var previews: some View {
        let mockDataAPIService = MockDataAPIService()
        let mockImageAPIService = MockImageAPIService()
        let locationsViewModel = LocationsViewModel(mockDataAPIService)
        let tipsViewModel = TipsViewModel(mockDataAPIService)
        let imageGalleryViewModel = ImageGalleryViewModel(mockImageAPIService, mockDataAPIService)
       return AppSideBarNavigation(locationsViewModel, imageGalleryViewModel, tipsViewModel)
    }
}
