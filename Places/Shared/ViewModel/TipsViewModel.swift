import Foundation
import Combine
import SwiftUI

enum ViewState {
    case idle
    case loading(LoadingView)
    case error(ErrorView)
    case content([Tip])
}

class TipsViewModel: ObservableObject {
    /// Bindable properties
    @Published var state = ViewState.idle

    // Private properties
    private let dataService: DataServiceUseCase
    private var bag = Set<AnyCancellable>()
    
//    /// The publisher
//    var tipsPublisher: AnyPublisher<ViewState, Never> {
//        dataService
//            .fetchTips()
//            .map({.content($0)})
//            .replaceError(with: .error(ErrorView()))
//            .share()
//            .eraseToAnyPublisher()
//    }
    
    /// Init requires any kind of `DataServiceUseCase` injection
    init(_ dataService: DataServiceUseCase) {
        self.dataService = dataService
    }
    
    /// Setup Bindings to Bindable properties with View
    func bind() {
        dataService
            .fetchTips()
            .receive(on: RunLoop.main)
            .map({.content($0)})
            .replaceError(with: .error(ErrorView()))
            .assign(to: \.state, on: self)
            .store(in: &bag)
    }
}
