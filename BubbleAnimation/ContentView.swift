import SwiftUI

struct ContentView: View {
    @State private var position: CGPoint = .init(x: 100, y: 100)
    
    var body: some View {
        GeometryReader { geometry in
            Canvas { context, size in
                let screenCenterPoint = CGPoint(
                    x: geometry.size.width / 2,
                    y: geometry.size.height / 2
                )
                
                let biggerRect = CGRect(
                    x: screenCenterPoint.x - (300 / 2),
                    y: screenCenterPoint.y - (300 / 2),
                    width: 300,
                    height: 300
                )
                
                let biggerText = Text("Hello World")
                    .font(.largeTitle)
                var resolvedBiggerText = context.resolve(biggerText)
                resolvedBiggerText.shading = .color(.white)
                
                var bubbleFilterContext = context
                // These filters are the key for the bubble effect
                bubbleFilterContext.addFilter(.alphaThreshold(min: 0.8, color: .pink))
                bubbleFilterContext.addFilter(.blur(radius: 22))
                // plus, drawing the two circles within the same layer
                bubbleFilterContext.drawLayer { localContext in
                    localContext.fill(
                        Circle().path(
                            in: .init(
                                x: position.x - (120 / 2),
                                y: position.y - (120 / 2),
                                width: 120,
                                height: 120
                            )
                        ),
                        with: .foreground
                    )
                    
                    localContext.fill(
                        Circle().path(in: biggerRect),
                        with: .foreground
                    )
                }
                
                context.draw(
                    resolvedBiggerText,
                    at: screenCenterPoint,
                    anchor: .center
                )
            }
            .background(Color.black.opacity(0.8).ignoresSafeArea())
            .gesture(
                DragGesture()
                    .onChanged {
                        gesture in
                        self.position = .init(
                            x: gesture.location.x,
                            y: gesture.location.y
                        )
                    }
            )
            .onTapGesture { point in
                self.position = point
            }
        }
    }
}

#Preview {
    ContentView()
}
