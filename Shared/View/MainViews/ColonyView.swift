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
        ZStack {
            /*ForEach(colony.aliveCells) {
                Text("")
            }*/
            Text("Testing")
        }
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
