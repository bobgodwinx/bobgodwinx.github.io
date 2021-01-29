//
//  TipsViewModel.swift
//  Places
//
//  Created by Bob Godwin Obi on 29.01.21.
//

import Foundation
import Combine

class TipsViewModel: ObservableObject {
    /// Bindable properties
    @Published var tips = [Tip]()

    // Private properties
    private let dataService: DataServiceUseCase
    private var bag = Set<AnyCancellable>()
    
    /// The publisher
    var tipsPublisher: AnyPublisher<[Tip], APIError> {
        dataService
            .fetchTips()
            .share()
            .eraseToAnyPublisher()
    }
    
    /// Init requires any kind of `DataServiceUseCase` injection
    init(_ dataService: DataServiceUseCase) {
        self.dataService = dataService
    }
    
    /// Setup Bindings to Bindable properties with View
    func bind() {
        tipsPublisher
            .receive(on: RunLoop.main)
            .replaceError(with: [])
            .assign(to: \.tips, on: self)
            .store(in: &bag)
    }
}

