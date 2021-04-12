//
//  ColonyView.swift
//  Conways_iPad (iOS)
//
//  Created by Natasa Zupanski on 4/9/21.
//

import SwiftUI

struct ColonyView: View {
    @State var colony : Colony
    var cells : [Coordinate] {
        return colony.livingCells()
    }
    //let name : String
    //var generationNumber : Int
    
    //func offsetX()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<cells.count) { index in
                    CellView(size: (Double(geometry.size.height)/60.0)) /*$colony.aliveCells[index]*//*Binding(
                            get: {self.cells[index]},
                            set: {self.colony.cellsAlive[index] = $0}
                    )*///)
                        .offset(x: CGFloat(Double(cells[index].col)*Double(geometry.size.height)/(60.0)),
                                y: CGFloat(Double( cells[index].row)*Double(geometry.size.height)/(60.0)))
                        .onTapGesture {
                            colony.setCellDead(row: colony.livingCells()[index].row, col: colony.livingCells()[index].col)
                        }
                }
                //Text("Testing")
            }
            .navigationBarTitle({
                return Text(colony.name) + Text("Generation: ") + Text(String(colony.generationNumber))
            }())
        }
    }
}

struct ColonyView_Previews: PreviewProvider {
    static var previews: some View {
        ColonyView(colony: {
            var colony = ColonyData.colonies[0]
            colony.setCellAlive(row: 1, col: 1)
            colony.setCellAlive(row: 2, col: 2)
            colony.setCellAlive(row: 3, col: 3)
            return colony
        }())//colony: Colony(size: 60))//, name: "Unnamed Colony", generationNumber: 2)
    }
}

struct CellView : View {
    let size : Double
    //let alive : Bool
    //@Binding var coordinate : Coordinate
    
    var body: some View {
        RoundedRectangle(cornerRadius: CGFloat(size / 5.0))
            .frame(width: CGFloat(size), height: CGFloat(size))
            .foregroundColor(.blue)
    }
}
