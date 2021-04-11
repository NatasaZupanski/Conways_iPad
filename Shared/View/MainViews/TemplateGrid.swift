//
//  TemplateGrid.swift
//  Conways_iPad (iOS)
//
//  Created by Natasa Zupanski on 4/10/21.
//

import SwiftUI

struct TemplateGrid: View {
    var templates : [Colony]
    var parsedTemplates : [(Colony, Colony?)] { // error here with amount of templates returned
        var parsed = [(Colony, Colony?)]()
        var count = 0
        var partial : (Colony, Colony?) = (Colony(size: 60), nil)
        for index in 0..<templates.count {
            if count == 0 {
                partial.0 = templates[index]
                count += 1
            }
            if count == 1 {
                partial.1 = templates[index]
                count = 0
                parsed += [partial]
            }
            if index == (templates.count - 1) && count == 0 {
                parsed += [partial]
            }
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
    
    var body: some View {
        
        VStack(alignment: .leading) {
            ForEach(parsedTemplates, id: \.self.0.id) { tuple in
                HStack {
                    Template(colony: tuple.0, width: 200.0)
                    if tuple.1 != nil {
                        Template(colony: tuple.1!, width: 200.0)
                    }
                }
            }
        }
    }
}

struct TemplateGrid_Previews: PreviewProvider {
    static var previews: some View {
        TemplateGrid(templates: [Colony(size: 60), Colony(size: 60), Colony(size: 60)])
    }
}
