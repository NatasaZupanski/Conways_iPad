//
//  ControlView.swift
//  Conways_iPad (iOS)
//
//  Created by Natasa Zupanski on 4/11/21.
//

import SwiftUI

struct ControlView: View {
    @EnvironmentObject var colonyData : ColonyData
    //@State var selectedID = UUID()
    
    var body: some View {
        List(colonyData.colonies) { colony in
            if colonyData.colonies[colonyData.selectedIndex].id == colony.id {
                ZStack {
                    Background(color: Color.gray.opacity(0.45))
                    //.animation(EaseInOut)
                    Text("\(colony.name)")
                        //.padding()
                        .cornerRadius(15.0)
                }
                    //.background(Background(color: Color.gray.opacity(0.5)))
            } else {
                ZStack {
                    Background(color: Color.white)
                        //.shadow(radius: 1)
                    Text("\(colony.name)")
                        //.background(Background(color: Color.white))
                        .onTapGesture {
                            makeSelected(colony)
                    }
                }
                    //.animation()
            }
        }
        /*Picker(colonyData.colonies[colonyData.selectedIndex].name, selection: $selectedID) {
            List(colonyData.colonies) { colony in
                Text("\(colony.name)").tag(colony.id)
            }
        }.onAppear {
            self.selectedID = colonyData.colonies[colonyData.selectedIndex].id
        }*/
    }
    
    func makeSelected(_ colony: Colony) {
        colonyData.selectedIndex = colonyData.colonies.firstIndex(where: {$0.id == colony.id})!
    }
}

struct ControlView_Previews: PreviewProvider {
    static var previews: some View {
        ControlView()
            .environmentObject(ColonyData())
    }
}
