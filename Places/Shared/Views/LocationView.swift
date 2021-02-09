//
//  LocationView.swift
//  Places
//
//  Created by Bob Godwin Obi on 26.01.21.
//

import SwiftUI

struct LocationView: View {
    @State var isPresented = false
    let location: Location
    
    init(with location: Location) {
        self.location = location
    }
    var body: some View {
        ScrollView {
            Image(location.heroPicture)
                .resizable()
                .scaledToFit()
                .iOS { $0.padding(.bottom, 10) }
                .macOS { $0.padding(.bottom, 10) }
                .popover(isPresented: $isPresented, content: locationImage)
                .onTapGesture(perform: tapGesture)
            Text(location.name)
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
            Text(location.country)
                .font(.title)
                .foregroundColor(.secondary)
            Text(location.description)
                .padding(.horizontal)
            Text("Did you know?")
                .font(.title3)
                .bold()
                .padding(.top)
            Text(location.more)
                .padding(.horizontal)
            
            Button("hello world", action: showSomething)
                .buttonStyle(primaryButtonStyle())
        }
        .navigationTitle("Discover")
    }
    
    func showSomething() {
        print("Nothing to show")
    }
    
    func locationImage() -> some View {
       ImageDetailView(image:  Image(location.heroPicture))
    }
    
    func tapGesture() {
        isPresented.toggle()
    }
}

struct LocationView_Previews: PreviewProvider {
    
    static var previews: some View {
        TabView {
            NavigationView {
                LocationView(with: Location.example)
            }
            .tabItem {
                Image(systemName: "airplane.circle.fill")
                Text("Discover")
            }
        }
    }
}
