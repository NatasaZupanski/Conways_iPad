//
//  NewColony.swift
//  Conways_iPad (iOS)
//
//  Created by Natasa Zupanski on 4/18/21.
//

//NOTE: BUG WHERE ADDING COLONY GOES TO COLONYVIEW, AS WANTED, BUT THEN IMMEDIATELY GOES BACK.

import SwiftUI

struct NewColony: View {
    //@State var text = " "
    //var colonyData = ColonyData()
    @EnvironmentObject var colonyData : ColonyData
    //@Environment(\.presentationMode) var mode : Binding<PresentationMode>
    //@StateObject var newTimer : ColonyTimer
    @State var template = "Blank"
    @State var newColony = Colony(size: 60)
    @State var backToColony = false
    //@State var added = false
    
    var body: some View {
        GeometryReader { geo in
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Name:")
                                .font(.title)
                                .fontWeight(.semibold)
                        TextField("Unnamed Colony", text: $newColony.name)
                            .font(.title)
                    }
                    Text("Templates")
                        .font(.title)
                        .fontWeight(.semibold)
                        
                    TemplateGrid(/*timer: ColonyTimer(Colony(size: 60)), */colony: $newColony, enableNew: false)
                    //TemplatesGrid()
                    //Spacer()
                }.padding(.horizontal)
                Divider()
                Template(colony: newColony, width: Double(geo.size.width) * (2.0/3.0), name: $newColony.name)
                NavigationLink(destination: ColonyView(colony: colonyData.colonies[colonyData.selectedIndex]), isActive: $backToColony) {
                    Text("")
                }
            }
            .navigationTitle("New Colony")
            .navigationBarItems(leading: Button(action: cancel) {
                Text("Cancel")
            }, trailing: addButton)
            //.navigationBarItems(trailing: addButton)
        }
    }
    
    func cancel() {
        self.backToColony = true
        //self.mode.wrappedValue.dismiss()
    }
    
    func addColony() {
        //newTimer.colony.originalTemplate = template
        //colonyData.timers.append(newTimer)
        
        newColony.originalTemplate = template
        colonyData.colonies.append(newColony)
        colonyData.selectedIndex = (colonyData.colonies.count - 1)
        //self.mode.wrappedValue.dismiss()
        //self.added = true
        //self.backToColony = true
        //cancel()
        // will add this to a button.
    }
    
    var addButton : some View {
        //HStack {
            /*NavigationLink(destination: ColonyView(colony: colonyData.colonies[colonyData.selectedIndex]), isActive: $backToColony) {
                Text("")
            }*/
        NavigationLink(destination: ColonyView(colony: colonyData.colonies[colonyData.selectedIndex])){
            Button(action: addColony) {
                Text("Add")
                    .foregroundColor(.blue)
            }
        }
        //}
        
    }
}

struct NewColony_Previews: PreviewProvider {
    static var previews: some View {
        NewColony(/*newTimer: ColonyTimer(Colony(size: 60)), */newColony: Colony(size: 60))
            .environmentObject(ColonyData())
    }
}
