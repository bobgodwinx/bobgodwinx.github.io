//
//  AppTabNavigation.swift
//  Places
//
//  Created by Bob Godwin Obi on 26.01.21.
//

import SwiftUI

struct compactView: View  {
    @ObservedObject var locationsViewModel: LocationsViewModel
    @ObservedObject var imageGalleryViewModel: ImageGalleryViewModel
    @ObservedObject var tipsViewModel: TipsViewModel
    
    @State private var selection: Navigation.Item = .location
    
    init(_ locationsViewModel: LocationsViewModel,
         _ imageGalleryViewModel: ImageGalleryViewModel,
         _ tipsViewModel: TipsViewModel) {
        self.locationsViewModel = locationsViewModel
        self.imageGalleryViewModel = imageGalleryViewModel
        self.tipsViewModel = tipsViewModel
    }
    
    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                NavigationView {
                    LocationView(with: locationsViewModel.primary)
                }
                .tabItem {
                    Image(systemName: "airplane.circle.fill")
                    Text("Discover")
                }
                .tag(Navigation.Item.location)
                
                NavigationView {
                    MapView(viewModel: locationsViewModel)
                }
                .tabItem {
                    Image(systemName: "map.fill")
                    Text("Locations")
                }
                .tag(Navigation.Item.map)
                
                NavigationView {
                    TipsView(viewModel: tipsViewModel)
                }
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Tips")
                }
                .tag(Navigation.Item.tips)
                
                NavigationView {
                    GalleryView(viewModel: imageGalleryViewModel)
                }
                .tabItem {
                    Image(systemName: "rectangle.3.offgrid")
                    Text("Gallery")
                }
                .tag(Navigation.Item.gallery)
            }
        }
    }
}

struct AppTabNavigation: View {
    
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
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    var body: some View {
        if horizontalSizeClass == .compact {
            compactView(locationsViewModel, imageGalleryViewModel, tipsViewModel)
        } else {
            AppTabNavigation(locationsViewModel, imageGalleryViewModel, tipsViewModel)
        }
    }
}

struct AppTabNavigation_Previews: PreviewProvider {
    static var previews: some View {
        let mockDataAPIService = MockDataAPIService()
        let mockImageAPIService = MockImageAPIService()
        let locationsViewModel = LocationsViewModel(mockDataAPIService)
        let tipsViewModel = TipsViewModel(mockDataAPIService)
        let imageGalleryViewModel = ImageGalleryViewModel(mockImageAPIService, mockDataAPIService)
        AppTabNavigation(locationsViewModel, imageGalleryViewModel, tipsViewModel)
    }
}
