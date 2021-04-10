//
//  Template.swift
//  Conways_iPad (iOS)
//
//  Created by Natasa Zupanski on 4/10/21.
//

import SwiftUI

struct Template: View {
    let colony : Colony
    var cells : [Coordinate] {
        return colony.livingCells()
    }
    var width : Double
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(colony.name)
                .fontWeight(.medium)
            GeometryReader { geometry in
                ZStack {
                    ForEach(0..<cells.count) { index in
                        CellView(size: (Double(geometry.size.width)/60.0)) /*$colony.aliveCells[index]*//*Binding(
                                get: {self.cells[index]},
                                set: {self.colony.cellsAlive[index] = $0}
                        )*///)
                            .offset(x: CGFloat(Double(cells[index].col)*Double(geometry.size.width)/(60.0)),
                                    y: CGFloat(Double( cells[index].row)*Double(geometry.size.width)/(60.0)))
                    }
                    //Text("Testing")
                }
            }
        }.frame(width: CGFloat(width))
    }
}

struct Template_Previews: PreviewProvider {
    static var previews: some View {
        Template(colony: {
            var colony = Colony(size: 60)
            colony.setCellAlive(row: 1, col: 1)
            colony.setCellAlive(row: 2, col: 2)
            colony.setCellAlive(row: 3, col: 3)
            return colony
        }(), width: 200.0)
    }
}
