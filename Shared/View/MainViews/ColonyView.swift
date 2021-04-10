//
//  ColonyView.swift
//  Conways_iPad (iOS)
//
//  Created by Natasa Zupanski on 4/9/21.
//

import SwiftUI

struct ColonyView: View {
    var colony : Colony
    let name : String
    var generationNumber : Int
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<colony.livingCells().count) { index in
                    CellView(size: Double(geometry.size.height)/60.0)
                        .offset(x: CGFloat(Double(colony.livingCells()[index].col)*Double(geometry.size.height)/(60.0)),
                                y: CGFloat(Double( colony.livingCells()[index].row)*Double(geometry.size.height)/(60.0)))
                }
                //Text("Testing")
            }
        }.navigationBarTitle({
            return Text(name) + Text("Generation: ") + Text(String(generationNumber))
        }())
    }
}

struct ColonyView_Previews: PreviewProvider {
    static var previews: some View {
        ColonyView(colony: Colony(size: 60), name: "Unnamed Colony", generationNumber: 2)
    }
}

struct CellView : View {
    let size : Double
    //let alive : Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: CGFloat(size / 10.0))
            .foregroundColor(.blue)
    }
}
