//
//  Navigation.swift
//  Places
//
//  Created by Bob Godwin Obi on 26.01.21.
//

import SwiftUI

struct Navigation: View {

    @ViewBuilder var body: some View {
        #if os(iOS)
            AppTabNavigation()
        #else
            AppSideBarNavigation()
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

