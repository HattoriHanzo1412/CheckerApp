

import Foundation
import SwiftData

@Model
class URLCheck {              
    var url: String
    var isPhish: Bool
    var confidence: Double
    var time: Date
    var isFavorite: Bool

    init(
        url: String,
        isPhish: Bool,
        confidence: Double,
        scannedAt: Date = .now,
        isFavorite: Bool = false
    ) {
        self.url = url
        self.isPhish = isPhish
        self.confidence = confidence
        self.time = scannedAt
        self.isFavorite = isFavorite
    }
}
//Model für SwiftDada Speicherung
