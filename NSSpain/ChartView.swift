import SwiftUI

struct SizePreferences: PreferenceKey {
  typealias Value = [Int: Anchor<CGRect>]
  
  static var defaultValue: Value { [:] }
  
  static func reduce(
    value: inout Value,
    nextValue: () -> Value
  ) {
    value.merge(nextValue()) { $1 }
  }
}

struct ChartView: View {
    
    struct CircleView: View {
        let index: Int
        var visible: Bool
        var text: String
        var body: some View {
            Circle()
                .foregroundColor(.yellow)
                .overlay(Text(text))
                .frame(width: 64, height: 64)
                .opacity(visible ? 1.0 : 0.0)
                .anchorPreference(key: SizePreferences.self, value: .bounds, transform: { anchor in
                    [index: anchor]
                })
        }
    }
    
    @State var visibleIndexes: [Bool] = [true, true, true, true]
    
    var body: some View {
        Group {
            VStack(alignment: .center) {
                HStack {
                    CircleView(index: 0, visible: visibleIndexes[0], text: "Child 1")
                    CircleView(index: 1, visible: visibleIndexes[1], text: "Child 2")
                    CircleView(index: 2, visible: visibleIndexes[2], text: "Child 3")
                }
                Spacer().frame(height: 20)
                HStack {
                    CircleView(index: 10, visible: visibleIndexes[3], text: "Parent")
                }
            }
            .backgroundPreferenceValue(SizePreferences.self) { value in
                GeometryReader { proxy in
                    ForEach(0..<3) { index in
                        Path { path in
                            path.move(to: value[index].map { proxy[$0].center } ?? .zero)
                            path.addLine(to: value[10].map { proxy[$0].center } ?? .zero)
                        }
                        .stroke(Color.blue, lineWidth: 10)
                        .opacity(visibleIndexes[index] ? 1.0 : 0.0)
                    }
                }
            }
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView().previewLayout(.fixed(width: 650, height: 480))
    }
}

extension CGRect {
    var center: CGPoint {
        CGPoint(x: midX, y: midY)
    }
}
