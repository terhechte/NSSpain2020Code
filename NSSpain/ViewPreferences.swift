import SwiftUI

struct TitlePreferenceKey: PreferenceKey {
  static var defaultValue = ""
  
  static func reduce(value: inout String, nextValue: () -> String) {
    value = nextValue()
  }
}

struct NewsView: View {
  let title = "News"
  var body: some View {
    VStack { EmptyView() }
      .preference(key: TitlePreferenceKey.self, value: title)
  }
}

struct FriendsView: View {
  let title = "Friends"
  var body: some View {
    VStack { EmptyView() }
      .preference(key: TitlePreferenceKey.self, value: title)
  }
}

struct ContainerView: View {
  @State var index = 0
  @State var currentTitle: String = ""
  @ViewBuilder var body: some View {
    VStack {
      Text(currentTitle)
      if index == 0 {
        NewsView()
      } else if index == 1 {
        FriendsView()
      }
    }
    .onPreferenceChange(TitlePreferenceKey.self) { self.currentTitle = $0 }
  }
}

struct ContainerView_Previews: PreviewProvider {
    static var previews: some View {
      ContainerView()
            .previewLayout(.fixed(width: 720, height: 480))
    }
}
