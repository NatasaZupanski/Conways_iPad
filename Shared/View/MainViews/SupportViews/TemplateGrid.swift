//
//  TemplateGrid.swift
//  Conways_iPad (iOS)
//
//  Created by Natasa Zupanski on 4/10/21.
//

import SwiftUI

struct TemplateGrid: View {
    var colonyData = ColonyData()
    
    // need to probably make an @EnvironmentObject of templates?
    @State var colony : Colony
    
    var colonyIndex : Int? {
        return ColonyData.colonies.firstIndex(where: {colony.id == $0 .id})
    }
    // need to make rework this with @StateObject ColonyData, colony, and colonyIndex
    
    var enableNew : Bool
    var parsedTemplates : [(Colony, Colony?)] {
        // error here with amount of templates returned
        var parsed = [(Colony, Colony?)]()
        //var count = 0
        var partial : (Colony, Colony?) = (Colony(size: 60), nil)
        for index in 0..<ColonyData.templates.count {
            if index%2 == 0 {
                partial.0 = ColonyData.templates[index]
                //count += 1
            }
            if index%2 == 1 {
                partial.1 = ColonyData.templates[index]
                //count = 0
                parsed += [partial]
            }
            if index == (ColonyData.templates.count - 1) && index%2 == 0 {
                partial.1 = nil
                parsed += [partial]
            }
            print("\(index): \(parsed.count)")
        }
        
        /*for template in templates {
            if count == 0 {
                partial.0 = template
                count += 1
            }
            if count == 1 {
                partial.1 = template
                count = 0
                parsed += [partial]
            }
        }*/
        return parsed
    }
    
    var count : CGFloat {
        if parsedTemplates.last!.1 == nil {
            return CGFloat(parsedTemplates.count)
        } else {
            return CGFloat(parsedTemplates.count + 1)
        }
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                ForEach(parsedTemplates, id: \.self.0.id) { tuple in
                    HStack(alignment: .center) {
                        Template(colony: tuple.0, width: (Double(geometry.size.width) / 2.0))
                            .onTapGesture {
                                setColony(newColony: tuple.0)
                            }
                        if tuple.1 != nil {
                            Template(colony: tuple.1!, width: (Double(geometry.size.width) / 2.0))
                                .onTapGesture {
                                    setColony(newColony: tuple.1!)
                                }
                        }
                        if enableNew && tuple.1 == nil {
                            //Spacer()
                            Button(action: addTemplate) {
                                Image(systemName: "plus")
                                    .foregroundColor(.blue)
                                    .frame(width: (CGFloat(Double(geometry.size.width)) / 2.0))
                            }
                            //Spacer()
                        }
                    }.frame(height: CGFloat(geometry.size.height/count))
                }
                if enableNew && parsedTemplates.last!.1 != nil {
                    Button(action: addTemplate) {
                        Image(systemName: "plus")
                            .foregroundColor(.blue)
                            .frame(width: (CGFloat(Double(geometry.size.width)) / 2.0), height: geometry.size.height / count)
                    }
                }
            }
        }
    }
    
    func setColonyFromTemplate(_ index: Int) {
        colony.setColonyFromCoors(cells: ColonyData.templates[index].livingCells())
    }
    
    func addTemplate() {
        ColonyData.templates.append(colony)
    }
    
    func setColony(newColony: Colony) {
        if colonyIndex != nil {
            ColonyData.colonies[colonyIndex!].setColonyFromCoors(cells: newColony.livingCells())
        } else if !enableNew {
            colony.setColonyFromCoors(cells: newColony.livingCells())
        }
    }
    
}

struct TemplateGrid_Previews: PreviewProvider {
    static var previews: some View {
        TemplateGrid(colony: Colony(size: 60), enableNew: true)
    }
}
