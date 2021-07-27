import UIKit
import Combine

var str = "Hello, playground"
var bag = Set<AnyCancellable>()

let p = [200].publisher
    p
    .append(201, 301)
    .append(401)
    .sink(receiveValue: { print($0) }) // 200 201 301 401
    .store(in: &bag)

// OR Concat stream of same type

let publisher1 = ["hello", "world"].publisher
let publisher2 = ["combine", "swift"].publisher
  
  publisher1
    .append(publisher2)
    .sink(receiveValue: { print($0) }) // hello world combine swift
    .store(in: &bag)

// OR you can go with different types but you
// have to make same type at the appending point
let publisher3 = ["hello"].publisher
let publisher4 = [4].publisher
  
publisher3
    .map({_ in 0 })
    .append(publisher4)
    .sink(receiveValue: { print($0) }) // hello world combine swift
    .store(in: &bag)

Publishers
    .Concatenate(prefix: Just("eheklekekek"), suffix: Just("vvvvvv"))
    .sink(receiveValue: { print($0) })
    .store(in: &bag)



let publisher11 = [[1,2,3],[4,5]].publisher
let publisher22 = [[300,400],[500]].publisher
let publisher23 = [[900,500],[800]].publisher
let publisher24 = [[100,99],[400]].publisher
let flatten11 = Publishers
    .Concatenate(prefix: publisher11, suffix: publisher22)
    .sink { value in
        print("Nested Concate : subscription received value \(value)")
    }




let publisher14 = [1,2,3,4,5].publisher
let publisher15 = [300,400,500].publisher
let flatten1 = Publishers
    .Concatenate(prefix: publisher1, suffix: publisher2)
    .sink { value in
        print("xx 🚀 Flatten Concate : subscription received value \(value)")
    }

let flatten12 = publisher11
    .append(publisher22)
    .append(publisher23)
    .append(publisher24)
    .collect()
    .sink { value in
    print("🚀 Nested append : subscription received value \(value)")
}


let passthroughSubject = PassthroughSubject<String, Never>()
let anySubscriber = AnySubscriber(passthroughSubject)
passthroughSubject.sink(
     receiveCompletion: { completion in
          print(completion)
     }) { value in
          print(value)
     }

[1, 2, 3, 4].publisher
    .filter { $0.isMultiple(of: 2) }
    .map { "My even number is \(String($0))" }
    .receive(subscriber: anySubscriber)

func update(name: String) -> AnyPublisher<Never, Never> {
    print("name update")
    return Empty().eraseToAnyPublisher()
}

class GenericSubscriber<T>: Subscriber {
    typealias Input = T
    typealias Failure = Never
    private var _onStarted: (() -> Void)? = nil
    private var _onEnded: (() -> Void)? = nil
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
        if let on = _onStarted {
            on()
        }
    }
    
    func receive(_ input: T) -> Subscribers.Demand {
        print("Received: \(input)", T.self)
        return .none
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        print("Completion event:", completion)
        if let ended = _onEnded {
            ended()
        }
    }
    
    func start(_ started: @escaping ()->()) {
        _onStarted = started
    }
    
    func ended(_ ended: @escaping ()->()) {
        _onEnded = ended
    }
}


let subscriberOfNever = GenericSubscriber<Never>()
subscriberOfNever.start {
    print("I am starting 🚀")
}
update(name: "Name").subscribe(subscriberOfNever)


public extension Publisher where Output: Equatable {
    @discardableResult func sink() -> AnyCancellable {
        sink(
            receiveCompletion: { _ in /* No handling needed */},
            receiveValue: { _ in /* No handling needed */ })
    }
}

struct Device {
    let name: String
}
struct User {
    let name: String
}

protocol DeviceRepositoryType {
    func query() -> AnyPublisher<[Device], Never>
}

protocol UserRepositoryType {
    func query() -> AnyPublisher<User, Never>
    func update(name: String) -> AnyPublisher<Never, Never>
}

enum ViewState: Equatable {
    struct Content: Equatable {
        let title: String
        let message: String
    }
    case loading
    case error
    case content(Content)
}

class ViewModel {
    fileprivate enum ActionState {
        case loading
        case idle
        case error
    }

    private let userRepository: UserRepositoryType
    private let deviceRepository: DeviceRepositoryType
    private let actionState = CurrentValueSubject<ActionState, Never>(.idle)

    init(userRepository: UserRepositoryType, deviceRepository: DeviceRepositoryType) {
        self.userRepository = userRepository
        self.deviceRepository = deviceRepository
    }

    func viewState() -> AnyPublisher<ViewState, Never> {
        Publishers.CombineLatest3(
            userRepository.query(),
            deviceRepository.query(),
            actionState
        )
            .map(toViewState)
            .eraseToAnyPublisher()
    }
    

    func update(userName: String) {
        let subscriberOfNever = GenericSubscriber<Never>()
        subscriberOfNever.start { self.actionState.send(.loading) }
        subscriberOfNever.ended { self.actionState.send(.idle) }
        userRepository
            .update(name: userName)
            .subscribe(subscriberOfNever)
        


//        userRepository.update(name: userName)
//            .handleEvents(
//                receiveSubscription: { _ in
//                    self.actionState.send(.loading)
//                },
//                receiveCompletion: { completion in
//                    switch completion {
//                    case .finished:
//                        self.actionState.send(.idle)
//                    case .failure:
//                        self.actionState.send(.error)
//                    }
//                })
//            .sink()

    }
}

private func toViewState(user: User, devices: [Device], actionState: ViewModel.ActionState) -> ViewState {
    if actionState == .loading {
        return .loading
    }

    if actionState == .error {
        return .error
    }

    let content = ViewState.Content(
        title: "Hello \(user.name)",
        message: "You have \(devices.count) on your profile"
    )
    return .content(content)
}











