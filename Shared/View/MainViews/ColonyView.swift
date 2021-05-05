//
//  ColonyView.swift
//  Conways_iPad (iOS)
//
//  Created by Natasa Zupanski on 4/9/21.
//

//
//  ColonyView.swift
//  TestingGitHub (iOS)
//
//  Created by Natasa Zupanski on 4/23/21.
//

import SwiftUI

struct ColonyView: View {
    @EnvironmentObject var colonyData : ColonyData
    var colony : Colony
    var colonyIndex : Int? {
        colonyData.colonies.firstIndex(where: {$0.id == colony.id})
    }
    @State var setAlive = false
    @State var startOfDrag = true
    //let gesture = DragGesture(coordinateSpace: .named("ColonyView"))
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                Rectangle()
                    //.frame(width: geometry.size.height)
                //Rectangle()
                    .foregroundColor(.white)
                ForEach(colony.aliveCells) { cell in
                    //Text("*")
                    CellView(size: (Double(geometry.size.height)/60.0))
                        /*.onAppear {
                            if colonyData.colonies[colonyIndex!].aliveCells.contains(cell) {
                                self.cellAlive = true
                            }
                            else {
                                self.cellAlive = false
                            }
                        }*/
                        .offset(x: CGFloat(Double(cell.col)*Double(geometry.size.height)/(60.0)),
                            y: CGFloat(Double( cell.row)*Double(geometry.size.height)/(60.0)))
                        /*.onTapGesture {
                            colonyData.colonies[colonyIndex!].setCellDead(row: cell.row, col: cell.col)
                        }*/
                
                }
            }//.navigationBackButtonHidden(true)
            //.frame(width: geometry.size.height)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(trailing: Button(action: lock) {Image(systemName: colonyData.colonies[colonyData.selectedIndex].locked ? "lock.fill" : "lock.open.fill")})
            .navigationTitle("\(colonyData.colonies[colonyData.selectedIndex].name) : Genreation #\(colonyData.colonies[colonyData.selectedIndex].generationNumber)")
            .background(Color.white)
            //.coordinateSpace(name: "ColonyView")
            .gesture(DragGesture(minimumDistance: 0.0).onChanged({ value in
                if !colonyData.colonies[colonyData.selectedIndex].locked {
                /*if startOfDrag {
                    let startPosition = value.location
                    print(startPosition)
                    //
                    let coordinate = positionToCoordinate(height: geometry.size.height, x: startPosition.x, y: startPosition.y)
                    if colonyData.colonies[colonyIndex!].isCellAlive(row: coordinate.row, col: coordinate.col) {
                        self.setAlive = false
                        colonyData.colonies[colonyIndex!].setCellDead(row: coordinate.row, col: coordinate.col)
                    } else {
                        self.setAlive = true
                        colonyData.colonies[colonyIndex!].setCellAlive(row: coordinate.row, col: coordinate.col)
                    }
                    
                    // EVERYTHING DONE
                    startOfDrag = false
                } else {
                    let coordinate = positionToCoordinate(height: geometry.size.height, x: value.location.x, y: value.location.y)
                    if setAlive && !colonyData.colonies[colonyIndex!].isCellAlive(row: coordinate.row, col: coordinate.col) {
                        colonyData.colonies[colonyIndex!].setCellAlive(row: coordinate.row, col: coordinate.col)
                    } else if colonyData.colonies[colonyIndex!].isCellAlive(row: coordinate.row, col: coordinate.col){
                        colonyData.colonies[colonyIndex!].setCellDead(row: coordinate.row, col: coordinate.col)
                    }
                }*/
                let height = geometry.size.height
                if startOfDrag {
                    let start = value.startLocation
                    //print(start)
                    let startCoordinate = positionToCoordinate(height: height, x: start.x, y: start.y)
                    print(startCoordinate)
                    if colonyData.colonies[colonyIndex!].isCellAlive(row: startCoordinate.row, col: startCoordinate.col) {
                        if colonyData.colonies[colonyIndex!].withinBounds(row: startCoordinate.row, col: startCoordinate.col) {
                            self.setAlive = false
                            colonyData.colonies[colonyIndex!].setCellDead(row: startCoordinate.row, col: startCoordinate.col)
                        }
                    } else {
                        if colonyData.colonies[colonyIndex!].withinBounds(row: startCoordinate.row, col: startCoordinate.col) {
                            self.setAlive = true
                            colonyData.colonies[colonyIndex!].setCellAlive(row: startCoordinate.row, col: startCoordinate.col)
                        }
                    }
                    startOfDrag = false
                    print("To set: \(setAlive ? "alive" : "dead")")
                }
                
                let coordinate = positionToCoordinate(height: height, x: value.location.x, y: value.location.y)
                print(coordinate)
                if setAlive {
                    if !colonyData.colonies[colonyIndex!].isCellAlive(row: coordinate.row, col: coordinate.col) {
                        if colonyData.colonies[colonyIndex!].withinBounds(row: coordinate.row, col: coordinate.col) {
                            //print(!colonyData.colonies[colonyIndex!].isCellAlive(row: coordinate.row, col: coordinate.col))
                            colonyData.colonies[colonyIndex!].setCellAlive(row: coordinate.row, col: coordinate.col)
                        }
                    }
                } else {
                    if colonyData.colonies[colonyIndex!].isCellAlive(row: coordinate.row, col: coordinate.col) {
                        if colonyData.colonies[colonyIndex!].withinBounds(row: coordinate.row, col: coordinate.col) {
                            colonyData.colonies[colonyIndex!].setCellDead(row: coordinate.row, col: coordinate.col)
                        }
                    }
                }
                }
            }).onEnded { value in
                startOfDrag = true
            })
            //.background(Color.white)
            /*.onTapGesture {
                colonyData.colonies[colonyIndex!].setCellAlive(row: 4, col: 4)
            }*/

        }
        
    }
    
    
    func lock() {
        colonyData.colonies[colonyData.selectedIndex].locked.toggle()
    }
    
    func positionToCoordinate(height: CGFloat, x: CGFloat, y: CGFloat) -> (row: Int, col: Int) {
        var coordinate = (row: 61, col: 61)
        
        let doubleHeight = Double(height)
        let doubleX = Double(x)
        let doubleY = Double(y)
        
        let length = doubleHeight / 60.0
        
        for colIndex in 0...59 {
            if (doubleX > (Double(colIndex) * length)) && (doubleX < (Double(colIndex + 1) * length)) {
                coordinate.col = colIndex
            }
        }
        
        for rowIndex in 0...59 {
            if (doubleY > (Double(rowIndex) * length)) && (doubleY < (Double(rowIndex + 1) * length)) {
                coordinate.row = rowIndex
            }
        }
        
        return coordinate
    }
}

struct ColonyView_Previews: PreviewProvider {
    static var previews: some View {
        ColonyView(colony: Colony(size: 60))
            .environmentObject(ColonyData())
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


/*import SwiftUI

struct ColonyView: View {
    @EnvironmentObject var timer : ColonyTimer
    var cells : [Coordinate] {
        timer.colony.livingCells()
    }
    @EnvironmentObject var colonyData : ColonyData
    //var colonyData = ColonyData()
    var colonyIndex : Int? {
        return colonyData.colonies.firstIndex(where: {timer.id == $0 .id})
    }
    //let name : String
    //var generationNumber : Int
    
    //func offsetX()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                //Rectangle()
                    //.foregroundColor(.white)
                /*ForEach(0..<cells.count) { index in
                    CellView(size: (Double(geometry.size.height)/60.0)) /*$colony.aliveCells[index]*//*Binding(
                            get: {self.cells[index]},
                            set: {self.colony.cellsAlive[index] = $0}
                    )*///)
                        .offset(x: CGFloat(Double(cells[index].col)*Double(geometry.size.height)/(60.0)),
                                y: CGFloat(Double( cells[index].row)*Double(geometry.size.height)/(60.0)))
                        .onTapGesture {
                            colony.setCellDead(row: colony.livingCells()[index].row, col: colony.livingCells()[index].col)
                        }
                }*/
                
                ForEach(cells) { cell in
                    CellView(size: (Double(geometry.size.height)/60.0))
                        .offset(x: CGFloat(Double(cell.col)*Double(geometry.size.height)/(60.0)),
                                y: CGFloat(Double( cell.row)*Double(geometry.size.height)/(60.0)))
                        .onTapGesture {
                            //timer.colony.setCellDead(row: cell.row, col: cell.col)
                            colonyData.timers[colonyIndex!].colony.setCellDead(row: cell.row, col: cell.col)
                            print("tapped")
                            print(timer.colony.isCellAlive(row: cell.row, col: cell.col))
                        }
                }
                //Text("Testing")
            }
            /*.navigationBarTitle({
                return Text(timer.colony.name) + Text(" | Generation: ") + Text(String(timer.colony.generationNumber))
            }())*/
        }
    }
    
}

struct ColonyView_Previews: PreviewProvider {
    static var previews: some View {
        ColonyView()
            .environmentObject(
                { () -> ColonyTimer in
                let timer = ColonyData().timers[0]
                timer.colony.setCellAlive(row: 1, col: 1)
                timer.colony.setCellAlive(row: 2, col: 2)
                timer.colony.setCellAlive(row: 3, col: 3)
                return timer
            }())
        //colony: Colony(size: 60))//, name: "Unnamed Colony", generationNumber: 2)
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
}*/
