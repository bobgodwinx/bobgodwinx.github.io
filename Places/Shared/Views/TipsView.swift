//
//  TipsView.swift
//  Places
//
//  Created by Bob Godwin Obi on 26.01.21.
//

import SwiftUI

struct TipsView: View {
    @ObservedObject var viewModel: TipsViewModel
    
    init(viewModel: TipsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        List(viewModel.tips, id: \.hash, children: \.children) { tip in
            if tip.children != nil {
                Label(tip.text, systemImage: "quote.bubble")
                    .font(.headline)
            } else {
                Text(tip.text)
            }
        }
        .navigationTitle("Tips")
    }
}

struct TipsView_Previews: PreviewProvider {
    static var previews: some View {
        let service = MockDataAPIService()
        let viewModel = TipsViewModel(service)
        viewModel.tips = MockDataAPIService.makeTips()
        
        return TabView {
            NavigationView {
                TipsView(viewModel: viewModel)
            }
            .tabItem {
                Image(systemName: "airplane.circle.fill")
                Text("Discover")
            }
        }
    }
}
