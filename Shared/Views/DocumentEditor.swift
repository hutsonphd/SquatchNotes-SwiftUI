//
//  DocumentEditor.swift
//  SquatchNotes
//
//  Created by Hutson on 3/30/21.
//

import SwiftUI
import HighlightedTextEditor

struct DocumentEditor: View {
    @Binding var document: TextFile
    
    var body: some View {
        HighlightedTextEditor(text: $document.text, highlightRules: .markdown)
    }
}

struct DocumentEditor_Previews: PreviewProvider {
    static var previews: some View {
        DocumentEditor(document: .constant(TextFile()))
    }
}
