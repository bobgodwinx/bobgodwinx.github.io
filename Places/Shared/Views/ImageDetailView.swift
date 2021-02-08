//
//  ImageDetailView.swift
//  Places
//
//  Created by Bob Godwin Obi on 01.02.21.
//

import SwiftUI

struct ImageDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    let image: Image
    
    var body: some View {
        image
            .collectionImageModifier()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .onTapGesture { presentationMode.wrappedValue.dismiss() }
    }
}

struct ImageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ImageDetailView(image: Image("photo4"))
    }
}
