import SwiftUI

struct GeometryReader2: View {
    @State var text: String = ""
    var body: some View {
        Text(text)
            .overlay(GeometryReader { proxy in
                Rectangle()
                    .foregroundColor(.clear)
                    .preference(key: SizePreferenceKey.self, value: proxy.size)
            })
            .onPreferenceChange(SizePreferenceKey.self) { p in
                self.text = "\(p.width) \(p.height)"
            }
    }
}

fileprivate struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}


struct GeometryReader2_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader2().previewLayout(.fixed(width: 650, height: 480))
    }
}
