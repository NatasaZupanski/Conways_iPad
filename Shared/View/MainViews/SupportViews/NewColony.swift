//
//  NewColony.swift
//  Conways_iPad (iOS)
//
//  Created by Natasa Zupanski on 4/18/21.
//

import SwiftUI

struct NewColony: View {
    @State var text = ""
    var colonyData = ColonyData()
    @State var newColony = Colony(size: 60)
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("Name:")
                            .font(.title)
                            .fontWeight(.semibold)
                    TextField("Unnamed Colony", text: $text)
                        .font(.title)
                }
                Text("Templates")
                    .font(.title)
                    .fontWeight(.semibold)
                    
                TemplateGrid(colony: newColony, enableNew: false)
                //TemplatesGrid()
                //Spacer()
            }.padding(.horizontal)
            Divider()
            Template(colony: newColony, width: 500.0)
        }
    }
    
    func addColony() {
        ColonyData.colonies.append(newColony)
    }
}

struct NewColony_Previews: PreviewProvider {
    static var previews: some View {
        NewColony()
    }
}
