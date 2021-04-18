//
//  ContentView.swift
//  Shared
//
//  Created by Natasa Zupanski on 4/9/21.
//


// Should this be the composite view??
import SwiftUI

struct ContentView: View {
    @State var colony: Colony
    
    var body: some View {
        NavigationView {
            HStack {
                    VStack {
                        Text("Controls")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.bottom, -1.0)
                        TabbedView(colony: colony)
                    }
                    .frame(minWidth: 0, idealWidth: 75, maxWidth: 300, minHeight: 0, idealHeight: 100, maxHeight: .infinity, alignment: .leading)
                    
                    VStack {
                        Text("Colony: \(colony.name) | Generation: \(colony.generationNumber)")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.bottom, -3.0)
                        ColonyView(colony: colony)
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView(colony: {
                var colony = ColonyData.colonies[0]
                colony.setCellAlive(row: 1, col: 1)
                colony.setCellAlive(row: 2, col: 2)
                colony.setCellAlive(row: 3, col: 3)
                return colony
            }())
    }
}
