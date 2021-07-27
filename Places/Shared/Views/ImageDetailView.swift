//
//  ImageDetailView.swift
//  Places
//
//  Created by Bob Godwin Obi on 01.02.21.
//

import SwiftUI

struct ImageDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @GestureState var scale: CGFloat = 1.0
    @State var pointTapped: CGPoint = CGPoint.zero
    @State var isTapped: Bool = false
    
    let image: Image
    
    var body: some View {
        
        let magnificationGesture = MagnificationGesture()
            .updating($scale) { (value, currentScale, transaction) in
                currentScale = value.magnitude
            }
        
        ScrollView {
            Spacer(minLength: 25)
            image
                .collectionImageModifier()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
                //.onTapGesture(count: 2, perform: doubleTapGesture)
                //.onTapGesture(perform: tapGesture)
                .scaleEffect(scale)
                .gesture(magnificationGesture)
        }
        .navigationTitle("ImageDetailView")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func doubleTapGesture() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct ImageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ImageDetailView(image: Image("photo4"))
    }
}
