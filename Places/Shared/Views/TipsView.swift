import SwiftUI
import Combine

struct LoadingView: View {
    var body: some View {
        ProgressView()
    }
}

struct ErrorView: View {
    var body: some View {
        Text("User Error")
    }
}

struct TipsViewCLE: View {
    @ObservedObject var viewModel: TipsViewModel
    var body: some View {
        VStack {
            switch viewModel.state {
            case .idle:
                EmptyView()
            case let .loading(loadingView):
                loadingView
            case let .error(errorView):
                errorView
            case let .content(tips):
                List(tips,
                     id: \.hash,
                     children: \.children,
                     rowContent: TipView.init)
                    .navigationTitle("Tips")
                    .listStyle(InsetGroupedListStyle())
            }
        }
    }
}

struct TipsView: View {
    @ObservedObject var viewModel: TipsViewModel

    init(viewModel: TipsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        TipsViewCLE(viewModel: viewModel)
        Spacer()
    }
}

struct TipsView_Previews: PreviewProvider {
    static var previews: some View {
        let service = MockDataAPIService()
        let viewModel = TipsViewModel(service)
        viewModel.state = ViewState.content(MockDataAPIService.makeTips())
        
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





