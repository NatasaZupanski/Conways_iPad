//
//  ColonyView.swift
//  Conways_iPad (iOS)
//
//  Created by Natasa Zupanski on 4/9/21.
//

import SwiftUI

struct ColonyView: View {
    var colony : Colony
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ColonyView_Previews: PreviewProvider {
    static var previews: some View {
        ColonyView(colony: Colony(size: 60))
    }
}

struct CellView : View {
    let size : Double
    
    var body: some View {
        RoundedRectangle(cornerRadius: CGFloat(size / 10.0))
    }
}
