import SwiftUI

struct TextComponent {
    let text: Text

    fileprivate let range: Range<String.Index>
}

// MARK: -
extension String {
    func components(for highlight: String) -> [TextComponent] {
        let highlightedRanges = ranges(of: highlight, options: .caseInsensitive)
        let highlightedComponents = highlightedRanges.map {
            TextComponent(
                text: .init(self[$0]).customAttribute(HighlightAttribute()),
                range: $0
            )
        }

        let remainingRanges = ranges(excluding: highlightedRanges)
        let remainingComponents = remainingRanges.map {
            TextComponent(
                text: .init(self[$0]),
                range: $0
            )
        }

        let components = highlightedComponents + remainingComponents
        return components.sorted(using: KeyPathComparator(\.range.lowerBound))
    }
}

// MARK: -
private extension String {
    func ranges(of substring: String, options: CompareOptions = [], locale: Locale? = nil) -> [Range<Index>] {
        var ranges: [Range<Index>] = []
        while let range = range(of: substring, options: options, range: (ranges.last?.upperBound ?? startIndex)..<endIndex, locale: locale) {
            ranges.append(range)
        }

        return ranges
    }

    func ranges(excluding ranges: [Range<Index>]) -> [Range<Index>] {
        var results: [Range<Index>] = []
        var currentIndex = startIndex

        let sortedRanges = ranges.sorted(using: KeyPathComparator(\.lowerBound))
        for range in sortedRanges {
            if currentIndex < range.lowerBound {
                results.append(currentIndex..<range.lowerBound)
            }

            currentIndex = range.upperBound
        }

        if currentIndex < endIndex {
            results.append(currentIndex..<endIndex)
        }

        return results
    }
}
