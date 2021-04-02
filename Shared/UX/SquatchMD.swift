//
//  SquatchMD.swift
//  SquatchNotes (iOS)
//
//  Created by Hutson on 4/2/21.
//

import SwiftUI
import Foundation
import HighlightedTextEditor

fileprivate let inlineCodeRegex = try! NSRegularExpression(pattern: "`[^`]*`", options: [])
fileprivate let codeBlockRegex = try! NSRegularExpression(pattern: "(`){3}((?!\\1).)+\\1{3}", options: [.dotMatchesLineSeparators])
fileprivate let heading1Regex = try! NSRegularExpression(pattern: "^#{1}\\s.*$", options: [.anchorsMatchLines])
fileprivate let heading2Regex = try! NSRegularExpression(pattern: "^#{2}\\s.*$", options: [.anchorsMatchLines])
fileprivate let heading3Regex = try! NSRegularExpression(pattern: "^#{3,6}\\s.*$", options: [.anchorsMatchLines])
fileprivate let linkOrImageRegex = try! NSRegularExpression(pattern: "!?\\[([^\\[\\]]*)\\]\\((.*?)\\)", options: [])
fileprivate let linkOrImageTagRegex = try! NSRegularExpression(pattern: "!?\\[([^\\[\\]]*)\\]\\[(.*?)\\]", options: [])
fileprivate let boldRegex = try! NSRegularExpression(pattern: "((\\*|_){2})((?!\\1).)+\\1", options: [])
fileprivate let underscoreEmphasisRegex = try! NSRegularExpression(pattern: "(?<!_)_[^_]+_(?!\\*)", options: [])
fileprivate let asteriskEmphasisRegex = try! NSRegularExpression(pattern: "(?<!\\*)(\\*)((?!\\1).)+\\1(?!\\*)", options: [])
fileprivate let boldEmphasisAsteriskRegex = try! NSRegularExpression(pattern: "(\\*){3}((?!\\1).)+\\1{3}", options: [])
fileprivate let blockquoteRegex = try! NSRegularExpression(pattern: "^>.*", options: [.anchorsMatchLines])
fileprivate let horizontalRuleRegex = try! NSRegularExpression(pattern: "\n\n(-{3}|\\*{3})\n", options: [])
fileprivate let unorderedListRegex = try! NSRegularExpression(pattern: "^(\\-|\\*)\\s", options: [.anchorsMatchLines])
fileprivate let orderedListRegex = try! NSRegularExpression(pattern: "^\\d*\\.\\s", options: [.anchorsMatchLines])
fileprivate let buttonRegex = try! NSRegularExpression(pattern: "<\\s*button[^>]*>(.*?)<\\s*/\\s*button>", options: [])
fileprivate let strikethroughRegex = try! NSRegularExpression(pattern: "(~)((?!\\1).)+\\1", options: [])
fileprivate let tagRegex = try! NSRegularExpression(pattern: "^\\[([^\\[\\]]*)\\]:", options: [.anchorsMatchLines])
fileprivate let footnoteRegex = try! NSRegularExpression(pattern: "\\[\\^(.*?)\\]", options: [])
// courtesy https://www.regular-expressions.info/examples.html
fileprivate let htmlRegex = try! NSRegularExpression(pattern: "<([A-Z][A-Z0-9]*)\\b[^>]*>(.*?)</\\1>", options: [.dotMatchesLineSeparators, .caseInsensitive])

#if os(macOS)
let codeFont = NSFont.monospacedSystemFont(ofSize: NSFont.systemFontSize, weight: .thin)
let headingTraits: NSFontDescriptor.SymbolicTraits = [.bold, .expanded]
let boldTraits: NSFontDescriptor.SymbolicTraits = [.bold]
let emphasisTraits: NSFontDescriptor.SymbolicTraits = [.italic]
let boldEmphasisTraits: NSFontDescriptor.SymbolicTraits = [.bold, .italic]
let secondaryBackground = NSColor.windowBackgroundColor
let lighterColor = NSColor.lightGray
let textColor = NSColor.labelColor
#else
let codeFont = UIFont.monospacedSystemFont(ofSize: 18, weight: .regular)
let heading1Font = UIFont(name: "Cabin-Bold", size: 32)
let heading2Font = UIFont(name: "Cabin-Bold", size: 26)
let heading3Font = UIFont(name: "Cabin-Bold", size: 22)
let headingTraits: UIFontDescriptor.SymbolicTraits = [.traitBold, .traitExpanded]
let boldTraits: UIFontDescriptor.SymbolicTraits = [.traitBold]
let emphasisTraits: UIFontDescriptor.SymbolicTraits = [.traitItalic]
let boldEmphasisTraits: UIFontDescriptor.SymbolicTraits = [.traitBold, .traitItalic]
let secondaryBackground = UIColor.secondarySystemBackground
let lighterColor = UIColor.lightGray
let textColor = UIColor.squatchText
let heading1Color = UIColor(hex: 0x339989)
let heading2Color = UIColor(hex: 0x716CAE)
let heading3Color = UIColor(hex: 0xF6486B)
let boldColor = UIColor(hex: 0xF4B860)
let codeColor = UIColor(hex: 0xFA805F)
#endif

// HighlightedTextEditor.markdown will only be accessible via [HighlightRule].markdown in a future 2.0.0 breaking release
// It does not really make any sense to have it here
public extension HighlightedTextEditor {
    static let SquatchMarkdown: [HighlightRule] = [HighlightRule].SquatchMarkdown
}

public extension Sequence where Iterator.Element == HighlightRule {
    static var SquatchMarkdown: [HighlightRule] {
        [
            HighlightRule(pattern: inlineCodeRegex, formattingRules: [
                TextFormattingRule(key: .font, value: codeFont),
                TextFormattingRule(key: .foregroundColor, value: codeColor)
                ]),
            HighlightRule(pattern: codeBlockRegex, formattingRules: [
                TextFormattingRule(key: .font, value: codeFont),
                TextFormattingRule(key: .foregroundColor, value: codeColor)
                ]),
            HighlightRule(pattern: heading1Regex, formattingRules: [
                TextFormattingRule(fontTraits: headingTraits),
                TextFormattingRule(key: .kern, value: 0.5),
                TextFormattingRule(key: .font, value: heading1Font!),
                TextFormattingRule(key: .foregroundColor, value: heading1Color)
            ]),
            HighlightRule(pattern: heading2Regex, formattingRules: [
                TextFormattingRule(fontTraits: headingTraits),
                TextFormattingRule(key: .kern, value: 0.5),
                TextFormattingRule(key: .font, value: heading2Font!),
                TextFormattingRule(key: .foregroundColor, value: heading2Color)
            ]),
            HighlightRule(pattern: heading3Regex, formattingRules: [
                TextFormattingRule(fontTraits: headingTraits),
                TextFormattingRule(key: .kern, value: 0.5),
                TextFormattingRule(key: .font, value: heading3Font!),
                TextFormattingRule(key: .foregroundColor, value: heading3Color)
            ]),
            HighlightRule(pattern: linkOrImageRegex, formattingRule: TextFormattingRule(key: .underlineStyle, value: NSUnderlineStyle.single.rawValue)),
            HighlightRule(pattern: linkOrImageTagRegex, formattingRule: TextFormattingRule(key: .underlineStyle, value: NSUnderlineStyle.single.rawValue)),
            HighlightRule(pattern: boldRegex, formattingRules: [
                TextFormattingRule(fontTraits: boldTraits),
                TextFormattingRule(key: .foregroundColor, value: boldColor)
            ]),
            HighlightRule(pattern: asteriskEmphasisRegex, formattingRule: TextFormattingRule(fontTraits: emphasisTraits)),
            HighlightRule(pattern: underscoreEmphasisRegex, formattingRule: TextFormattingRule(fontTraits: emphasisTraits)),
            HighlightRule(pattern: boldEmphasisAsteriskRegex, formattingRule: TextFormattingRule(fontTraits: boldEmphasisTraits)),
            HighlightRule(pattern: blockquoteRegex, formattingRule: TextFormattingRule(key: .backgroundColor, value: secondaryBackground)),
            HighlightRule(pattern: horizontalRuleRegex, formattingRule: TextFormattingRule(key: .foregroundColor, value: lighterColor)),
            HighlightRule(pattern: unorderedListRegex, formattingRule: TextFormattingRule(key: .foregroundColor, value: lighterColor)),
            HighlightRule(pattern: orderedListRegex, formattingRule: TextFormattingRule(key: .foregroundColor, value: lighterColor)),
            HighlightRule(pattern: buttonRegex, formattingRule: TextFormattingRule(key: .foregroundColor, value: lighterColor)),
            HighlightRule(pattern: strikethroughRegex, formattingRules: [
                TextFormattingRule(key: .strikethroughStyle, value: NSUnderlineStyle.single.rawValue),
                TextFormattingRule(key: .strikethroughColor, value: textColor)
            ]),
            HighlightRule(pattern: tagRegex, formattingRule: TextFormattingRule(key: .foregroundColor, value: lighterColor)),
            HighlightRule(pattern: footnoteRegex, formattingRule: TextFormattingRule(key: .foregroundColor, value: lighterColor)),
            HighlightRule(pattern: htmlRegex, formattingRules: [
                TextFormattingRule(key: .font, value: codeFont),
                TextFormattingRule(key: .foregroundColor, value: lighterColor)
            ])
        ]
    }
}

