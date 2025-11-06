
import SwiftData
import Foundation
import SwiftUI

struct DangerFlashOverlay: View {
    let show: Bool

    var body: some View {
        Group {
            if show {
                Color.red.opacity(0.18)
            } else {
                Color.clear
            }
        }
    }
}
