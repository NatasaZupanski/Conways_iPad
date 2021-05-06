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
    //@EnvironmentObject var timer: ColonyTimer
    @EnvironmentObject var colonyData : ColonyData
    
    var body: some View {
        NavigationView {
            //GeometryReader { geo in
            TabbedView()
                .navigationBarTitle("Navigation")
                .navigationBarItems(trailing: {
                    NavigationLink(destination: NewColony()) {
                        Image(systemName: "plus")
                            .foregroundColor(.blue)
                    }
                }())
            
            ColonyView(colony: colonyData.colonies[colonyData.selectedIndex])
            
                //.navigationTitle("\(colonyData.colonies[colonyData.selectedIndex].name) : Genreation #\(colonyData.colonies[colonyData.selectedIndex].generationNumber)")
                //.navigationBarBackButtonHidden(true)
                //.padding(24.0)
            //}
        }//.accessibilityHint(Text("Swipe left and right to change between the controls and list of colonies."))
    }
}

struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
                /*.environmentObject({ () -> ColonyTimer in 
                    let timer = ColonyData().timers[0]
                    timer.colony.setCellAlive(row: 1, col: 1)
                    timer.colony.setCellAlive(row: 2, col: 2)
                    timer.colony.setCellAlive(row: 3, col: 3)
                    return timer
                }())*/
                .environmentObject(ColonyData())
    }
}
