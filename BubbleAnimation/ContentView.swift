import SwiftUI

struct ContentView: View {
    @State private var position: CGPoint = .zero
    
    var body: some View {
        GeometryReader { geometry in
            let proxyWidth = geometry.size.width * 0.5
            let proxyHeight = geometry.size.height * 0.5
            
            Canvas { context, size in
                
                context.addFilter(.alphaThreshold(min: 0.8, color: .red))
                context.addFilter(.blur(radius: 22))
                
                context.drawLayer { graphicContext in
                    graphicContext.fill(
                        Circle().path(
                            in: .init(
                                x: proxyWidth + position.x - 50,
                                y: proxyWidth + position.y - 200,
                                width: 120,
                                height: 120
                            )
                        ),
                        with: .foreground
                    )
                    
                    graphicContext.fill(
                        Circle().path(
                            in: .init(
                                x: proxyWidth - 150,
                                y: proxyHeight - 300,
                                width: 300,
                                height: 300
                            )
                        ),
                        with: .foreground
                    )
                }
            }
            .gesture(
                DragGesture()
                    .onChanged {
                        gesture in
                        self.position = .init(
                            x: gesture.translation.width,
                            y: gesture.translation.height
                        )
                    }
            )
        }
    }
}

#Preview {
    ContentView()
}
