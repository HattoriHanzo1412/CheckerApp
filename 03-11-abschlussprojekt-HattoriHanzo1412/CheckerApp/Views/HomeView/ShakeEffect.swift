


import SwiftUI

struct ShakeEffect: GeometryEffect {
    var amount: CGFloat = 12
    var shakesPerUnit: CGFloat = 3
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        let x = amount * sin(animatableData * .pi * shakesPerUnit * 2)
        return ProjectionTransform(CGAffineTransform(translationX: x, y: 0))
    }
}
