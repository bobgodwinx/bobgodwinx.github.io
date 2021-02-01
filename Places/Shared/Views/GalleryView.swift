//
//  GalleryView.swift
//  Places
//
//  Created by Bob Godwin Obi on 26.01.21.
//

import SwiftUI

extension Image {
    func collectionImageModifier() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipped()
    }
}

struct GalleryView: View {
    @ObservedObject var viewModel: ImageGalleryViewModel
    
    init(viewModel: ImageGalleryViewModel) {
        self.viewModel = viewModel
    }
    
    var colums = [
        GridItem(spacing: 0),
        GridItem(spacing: 0),
        GridItem(spacing: 0)
    ]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true){
            LazyVGrid(columns: colums) {
                ForEach(viewModel.locationImages, id: \.id) { locationImage in
                    NavigationLink(destination: ImageDetailView(image: locationImage.image)) {
                        locationImage
                            .image
                            .collectionImageModifier()
                    }
                }
            }
        }
        .navigationTitle(Text("Gallery"))
        .onAppear(perform: viewModel.bind)
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        let mockDataAPIService = MockDataAPIService()
        let mockImageAPIService = MockImageAPIService()
        let viewModel = ImageGalleryViewModel(mockImageAPIService, mockDataAPIService)
        GalleryView(viewModel: viewModel)
    }
}
