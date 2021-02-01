//
//  ImageDetailView.swift
//  Places
//
//  Created by Bob Godwin Obi on 01.02.21.
//

import SwiftUI

struct ImageDetailView: View {
    let image: Image
    var body: some View { image.collectionImageModifier() }
}

struct ImageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ImageDetailView(image: Image("photo4"))
    }
}
