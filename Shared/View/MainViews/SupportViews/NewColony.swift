//
//  NewColony.swift
//  Conways_iPad (iOS)
//
//  Created by Natasa Zupanski on 4/18/21.
//

import SwiftUI

struct NewColony: View {
    //@State var text = " "
    //var colonyData = ColonyData()
    @EnvironmentObject var colonyData : ColonyData
    @StateObject var newTimer : ColonyTimer
    @State var template = "Blank"
    @State var newColony : Colony
    
    var body: some View {
        GeometryReader { geo in
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Name:")
                                .font(.title)
                                .fontWeight(.semibold)
                        TextField("Unnamed Colony", text: $newTimer.colony.name)
                            .font(.title)
                    }
                    Text("Templates")
                        .font(.title)
                        .fontWeight(.semibold)
                        
                    TemplateGrid(timer: newTimer, colony: newColony, enableNew: false)
                    //TemplatesGrid()
                    //Spacer()
                }.padding(.horizontal)
                Divider()
                Template(colony: newColony, width: Double(geo.size.width) * (2.0/3.0), name: $newTimer.colony.name)
            }
        }
    }
    
    func addColony() {
        //newTimer.colony.originalTemplate = template
        //colonyData.timers.append(newTimer)
        
        newColony.originalTemplate = template
        colonyData.colonies.append(newColony)
        // will add this to a button.
    }
    
    var button : some View {
        Button(action: addColony) {
            Text("+")
                .foregroundColor(.blue)
        }
    }
}

struct NewColony_Previews: PreviewProvider {
    static var previews: some View {
        NewColony(newTimer: ColonyTimer(Colony(size: 60)), newColony: Colony(size: 60))
            .environmentObject(ColonyData())
    }
}
