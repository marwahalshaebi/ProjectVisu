//
//  SqureCornerRadius.swift
//  Visu
//
//  Created by Marwah Alshaebi on 2022-03-04.
//

import SwiftUI

struct SqureCornerRadius: Shape {

    let radius : CGFloat

    init(_ radius: CGFloat = 2.7) {
        self.radius = radius
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        // Drawing the rect
        path.move(to: CGPoint(x: rect.minX + radius, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - radius, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + radius))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - radius))
        path.addLine(to: CGPoint(x: rect.maxX - radius, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX + radius, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - radius))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + radius))
        path.addLine(to: CGPoint(x: rect.minX + radius, y: rect.minY))

        return path
    }
}
