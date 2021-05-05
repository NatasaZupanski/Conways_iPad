//
//  Background.swift
//  Conways_iPad (iOS)
//
//  Created by Natasa Zupanski on 4/29/21.
//

import SwiftUI

struct Background: View {
    var color : Color
    
    var body: some View {
        GeometryReader { geo in
        Rectangle()
            .foregroundColor(color)
            .foregroundColor(.clear)
            .frame(width: geo.size.width)
            .frame(height: 30)
            .cornerRadius(10.0)
        }
    }
}

struct Background_Previews: PreviewProvider {
    static var previews: some View {
        Background(color: Color.gray.opacity(0.5))
    }
}
