//
//  SqureCornerRadius.swift
//  Visu
//
//  Created by iMac on 04/03/22.
//

import SwiftUI

struct SqureCornerRadius: Shape {

    let radius : CGFloat

    init(_ radius: CGFloat = 6) {
        self.radius = radius
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
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
