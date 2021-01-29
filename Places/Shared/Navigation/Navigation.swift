//
//  Navigation.swift
//  Places
//
//  Created by Bob Godwin Obi on 26.01.21.
//

import SwiftUI

struct Navigation: View {
    /// All Dependency injections here! 👇🏾
    @StateObject var locationsViewModel = LocationsViewModel(DataAPIService.shared)
    @StateObject var tipsViewModel = TipsViewModel(DataAPIService.shared)
    @StateObject var imageViewModel = ImageGalleryViewModel(ImageAPIService.shared, DataAPIService.shared)

    @ViewBuilder var body: some View {
        #if os(iOS)
            AppTabNavigation(locationsViewModel, imageViewModel, tipsViewModel)
        #else
            AppSideBarNavigation(locationsViewModel, imageViewModel, tipsViewModel)
        #endif
    }
    
    enum Item {
        case location
        case map
        case tips
        case gallery
    }
}

struct Navigation_Previews: PreviewProvider {
    static var previews: some View {
        Navigation()
    }
}

