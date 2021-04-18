//
//  NewColony.swift
//  Conways_iPad (iOS)
//
//  Created by Natasa Zupanski on 4/18/21.
//

import SwiftUI

struct NewColony: View {
    //@State var text = " "
    var colonyData = ColonyData()
    @State var newColony = Colony(size: 60)
    @State var template = "Blank"
    
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
                        
                    TemplateGrid(colony: $newColony, enableNew: false)
                    //TemplatesGrid()
                    //Spacer()
                }.padding(.horizontal)
                Divider()
                Template(colony: newColony, width: Double(geo.size.width) * (2.0/3.0), name: $newColony.name)
            }
        }
    }
    
    func addColony() {
        newColony.originalTemplate = template
        ColonyData.colonies.append(newColony)
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
        NewColony()
    }
}
