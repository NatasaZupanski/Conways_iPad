//
//  TabbedView.swift
//  Conways_iPad (iOS)
//
//  Created by Natasa Zupanski on 4/11/21.
//

import SwiftUI

struct TabbedView: View {
    // If we do this, initating the ColonyData here may be best.
    
    var body: some View {
        TabView {
            ListView()
                .tabItem {
                    Image(systemName: "list.bullet")
                }
            ControlView()
                .tabItem {
                    Image(systemName: "slider.horizontal.3")
                }
        }
    }
}

struct TabbedView_Previews: PreviewProvider {
    static var previews: some View {
        TabbedView()
    }
}
