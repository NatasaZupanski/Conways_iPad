//
//  DetailText.swift
//  Conways_iPad (iOS)
//
//  Created by Natasa Zupanski on 4/10/21.
//

import SwiftUI

struct DetailText: View {
    var colony : Colony
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Details:")
                .font(.title)
                .fontWeight(.medium)
            Text("Name: ") + Text(colony.name)
            Text("Locked: ")
            Text("Original Template: ")
        }
    }
}

struct DetailText_Previews: PreviewProvider {
    static var previews: some View {
        DetailText(colony: Colony(size: 60))
    }
}
