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
    @State var added = false
    @State var showAdded = false
    @State var showUpdated = false
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
                Text(added ? "Done" : "Cancel")
            }, trailing: addButton)
            .overlay (
                //if showAdded {
                Text(showAdded ? "Colony Added. Press Done." : "")
                    .padding()
                    .background(showAdded ? Color.white : Color.clear)
                    .cornerRadius(10)
                    .shadow(radius: showAdded ? 1.0 : 0.0)
                    .animation(Animation.easeInOut)
                //}
            )
            .overlay (
                //if showAdded {
                Text(showUpdated ? "Colony Updated. Press Done." : "")
                    .padding()
                    .background(showUpdated ? Color.white : Color.clear)
                    .cornerRadius(10)
                    .shadow(radius: showUpdated ? 1.0 : 0.0)
                    .animation(Animation.easeInOut)
                //}
            )

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
        if !added {
            //newColony = Colony(size: 60)
            //newColony.originalTemplate = template
            colonyData.colonies.append(newColony)
            colonyData.selectedIndex = (colonyData.colonies.count - 1)
            self.added = true
            self.showAdded = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.showAdded = false
            }
        } else {
            self.showAdded = false
            //colonyData.colonies[colonyData.selectedIndex].originalTemplate = template
            //colonyData.colonies[colonyData.selectedIndex].name = newColony.name
            colonyData.colonies[colonyData.selectedIndex] = newColony
            //colonyData.colonies[colonyData.selectedIndex].originalTemplate = template
            self.showUpdated = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.showUpdated = false
            }
        }
        
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
        //NavigationLink(destination: ColonyView(colony: colonyData.colonies[colonyData.selectedIndex])){
            Button(action: addColony) {
                Text(added ? "Update" : "Add")
                    .foregroundColor(.blue)
            }
        //}
        //}
        
    }
}

struct NewColony_Previews: PreviewProvider {
    static var previews: some View {
        NewColony(/*newTimer: ColonyTimer(Colony(size: 60)), */newColony: Colony(size: 60))
            .environmentObject(ColonyData())
    }
}
