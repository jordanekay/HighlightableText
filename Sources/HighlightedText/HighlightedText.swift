public import SwiftUI

public struct HighlightedText {
    private let text: String
    private let highlight: String?
    private let shapeStyle: (any ShapeStyle)?
    private let cornerRadius: CGFloat

    public init(
        text: String,
        highlight: String?,
        shapeStyle: (any ShapeStyle)? = nil,
        cornerRadius: CGFloat = 0
    ) {
        self.text = text
        self.highlight = highlight
        self.shapeStyle = shapeStyle
        self.cornerRadius = cornerRadius
    }
}

// MARK: -
extension HighlightedText: View {
    public var body: some View {
        if let highlight, !highlight.isEmpty {
            let components = text.components(for: highlight)
            let renderer = HighlightTextRenderer(
                style: shapeStyle,
                cornerRadius: cornerRadius
            )

            components
                .map(\.text)
                .reduce(Text(""), +)
                .textRenderer(renderer)
        } else {
            Text(text)
        }
    }
}
