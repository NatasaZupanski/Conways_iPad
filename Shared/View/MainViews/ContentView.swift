//
//  ContentView.swift
//  Shared
//
//  Created by Natasa Zupanski on 4/9/21.
//


// Should this be the composite view??
import SwiftUI

struct ContentView: View {
//    @State var colony: Colony
    @EnvironmentObject var timer: ColonyTimer
    @EnvironmentObject var colonyData : ColonyData
    
    var body: some View {
        //NavigationView {
        HStack(spacing: 0.0) {
                VStack {
                    Text("Controls")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, -1.0)
                    TabbedView()
                }
                .frame(minWidth: 0, idealWidth: 75, maxWidth: 300, minHeight: 0, idealHeight: 100, maxHeight: .infinity, alignment: .leading)
                    
                Divider()
                
                VStack {
                    Text("Colony: \(timer.colony.name) | Generation: \(timer.colony.generationNumber)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, -3.0)
                    ColonyView(colony: colonyData.colonies[colonyData.selectedIndex])
                }
            }
        //}.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
                .environmentObject({ () -> ColonyTimer in 
                    let timer = ColonyData().timers[0]
                    timer.colony.setCellAlive(row: 1, col: 1)
                    timer.colony.setCellAlive(row: 2, col: 2)
                    timer.colony.setCellAlive(row: 3, col: 3)
                    return timer
                }())
                .environmentObject(ColonyData())
    }
}
