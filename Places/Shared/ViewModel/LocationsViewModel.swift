//
//  LocationsViewModel.swift
//  Places
//
//  Created by Bob Godwin Obi on 28.01.21.
//

import Foundation
import Combine

class LocationsViewModel: ObservableObject {
    /// Bindable properties
    @Published  var places = [Location]()
    @Published  var primary = Location.example
    
    /// Private properties
    private let dataService: DataServiceUseCase
    private var bag = Set<AnyCancellable>()
    
    /// The publisher
    var allLocationsPublisher: AnyPublisher<[Location], APIError> {
        dataService
            .fetchLocations()
            .share()
            .eraseToAnyPublisher()
    }

    /// Init requires any kind of `DataServiceUseCase` injection
    init(_ dataService: DataServiceUseCase) {
        self.dataService = dataService
    }
    
    /// Setup Bindings to Bindable properties with View
    func bind() {
        allLocationsPublisher
            .receive(on: RunLoop.main)
            .map({$0[0]})
            .catch({Just(Location.make(with: $0))})
            .assign(to: \.primary, on: self)
            .store(in: &bag)
        
        allLocationsPublisher
            .receive(on: RunLoop.main)
            .replaceError(with: [])
            .assign(to: \.places, on: self)
            .store(in: &bag)
    }
    
    deinit {
        bag = []
    }
}
