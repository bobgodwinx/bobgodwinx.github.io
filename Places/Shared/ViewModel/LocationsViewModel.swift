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

    /// Init requires any kind of `DataServiceUseCase` injection
    init(_ dataService: DataServiceUseCase) {
        self.dataService = dataService
    }
    
    deinit {
        bag = []
    }
}
