import SwiftUI

struct ContentView: View {
    @State private var position: CGPoint = .init(x: 100, y: 100)
    
    var body: some View {
        GeometryReader { geometry in
            Canvas { context, size in
                // These filters are the key for the bubble effect
                context.addFilter(.alphaThreshold(min: 0.8, color: .pink))
                context.addFilter(.blur(radius: 22))
                
                context.drawLayer { graphicContext in
                    
                    graphicContext.fill(
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
                    
                    graphicContext.fill(
                        Circle().path(
                            in: .init(
                                x: (geometry.size.width / 2) - (300 / 2),
                                y: (geometry.size.height / 2) - (300 / 2),
                                width: 300,
                                height: 300
                            )
                        ),
                        with: .foreground
                    )
                    
                }
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
