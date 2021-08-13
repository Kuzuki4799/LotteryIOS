//
//  CustomConor.swift
//  Lottery
//
//  Created by Nguyen Tri The on 30/07/2021.
//

import SwiftUI

struct CustomConor: Shape{
    var corner: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corner, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

