//
//  Note.swift
//  SquatchNotes
//
//  Created by Hutson on 3/18/21.
//

import Foundation
import SwiftUI

struct Note: Hashable, Codable, Identifiable {
    let id: String
    let name: String
    let body: String
    let description: String
    let lastModified: String
    
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
}
