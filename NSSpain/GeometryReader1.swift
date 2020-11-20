import SwiftUI

struct GeometryReader1: View {
    @State var text: String = ""
    var body: some View {
        Text(text)
            .overlay(GeometryReader { proxy in
                Rectangle()
                    .foregroundColor(.clear)
                    .onAppear {
                        self.text = "\(proxy.size.width) \(proxy.size.height)"
                    }
            })
    }
}


struct GeometryReader1_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader1().previewLayout(.fixed(width: 650, height: 480))
    }
}
