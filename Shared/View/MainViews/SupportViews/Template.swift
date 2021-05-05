//
//  Template.swift
//  Conways_iPad (iOS)
//
//  Created by Natasa Zupanski on 4/10/21.
//

import SwiftUI

struct Template: View {
    var colony : Colony
    var cells : [Coordinate] {
        return colony.aliveCells
    }
    var width : Double
    @Binding var name : String
    var previewing : Bool {
        if name != "" {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(previewing ? name : colony.name)
                .fontWeight(.medium)
            GeometryReader { geometry in
                ZStack {
                    /*ForEach(0..<cells.count) { index in
                        CellView(size: (Double(geometry.size.width)/60.0)) /*$colony.aliveCells[index]*//*Binding(
                                get: {self.cells[index]},
                                set: {self.colony.cellsAlive[index] = $0}
                        )*///)
                            .offset(x: CGFloat(Double(cells[index].col)*Double(geometry.size.width)/(60.0)),
                                    y: CGFloat(Double( cells[index].row)*Double(geometry.size.width)/(60.0)))
                    }*/
                    ForEach(colony.aliveCells) { cell in
                        CellView(size: (Double(geometry.size.height)/60.0))
                            .offset(x: CGFloat(Double(cell.col)*Double(geometry.size.height)/(60.0)),
                                    y: CGFloat(Double( cell.row)*Double(geometry.size.height)/(60.0)))
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
            var colony = ColonyData().templates[0]
            colony.setCellAlive(row: 1, col: 1)
            colony.setCellAlive(row: 2, col: 2)
            colony.setCellAlive(row: 3, col: 3)
            return colony
        }(), width: 200.0, name: .constant(""))
    }
}
