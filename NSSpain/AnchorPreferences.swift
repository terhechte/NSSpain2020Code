import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Text("Hello Spain!")
                .anchorPreference(key: AnchorPreferenceKey.self, value: .bounds, transform: {
                    $0 })
        }
        .backgroundPreferenceValue(AnchorPreferenceKey.self) { value in
            GeometryReader { proxy in
                if let actualAnchor = value {
                    Rectangle()
                        .foregroundColor(.blue)
                        .frame(
                            width: proxy[actualAnchor].width,
                            height: proxy[actualAnchor].height
                            )
                        .offset(
                            x: proxy[actualAnchor].origin.x,
                            y: proxy[actualAnchor].origin.y)
                } else {
                    EmptyView()
                }
            }
        }
    }
}

fileprivate struct AnchorPreferenceKey: PreferenceKey {
    typealias Value = Anchor<CGRect>?
    static var defaultValue: Value = nil

    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 650, height: 480))
    }
}
