import SwiftUI

struct HighlightTextRenderer {
    private let style: any ShapeStyle
    private let cornerRadius: CGFloat

    init(
        style: (any ShapeStyle)?,
        cornerRadius: CGFloat
    ) {
        self.style = style ?? .highlight
        self.cornerRadius = cornerRadius
    }
}

// MARK: -
extension HighlightTextRenderer: TextRenderer {
    func draw(layout: Text.Layout, in context: inout GraphicsContext) {
        for run in layout.flatMap(\.self) {
            let copy = context

            if run[HighlightAttribute.self] != nil {
                let rect = run.typographicBounds.rect
                let shape = RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                let path = shape.path(in: rect)

                copy.fill(path, with: .style(style))
            }

            copy.draw(run)
        }
    }
}

// MARK: -
private extension ShapeStyle where Self == Color {
    static var highlight: Self {
        .init(red: 1, green: 1, blue: 0)
    }
}
