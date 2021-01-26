//
//  AppSideBarNavigation.swift
//  Places
//
//  Created by Bob Godwin Obi on 26.01.21.
//

import SwiftUI

struct AppSideBarNavigation: View {
    
    @State private var selection: Set<Navigation.Item> = [.location]
    
    var sideBar: some View {
        List(selection: $selection) {
            NavigationLink(destination: LocationView()) {
                Label("Discover", systemImage: "airplane.circle.fill")
                    .tag(Navigation.Item.location)
            }
            
            NavigationLink(destination: MapView()) {
                Label("Map", systemImage: "map.fill")
                    .tag(Navigation.Item.map)
            }
            
            NavigationLink(destination: TipsView()) {
                Label("Tips", systemImage: "list.bullet")
                    .tag(Navigation.Item.tips)
            }
            
            NavigationLink(destination: GalleryView()) {
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
            LocationView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct AppSideBarNavigation_Previews: PreviewProvider {
    static var previews: some View {
        AppSideBarNavigation()
    }
}