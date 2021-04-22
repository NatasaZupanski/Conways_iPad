//
//  TabbedView.swift
//  Conways_iPad (iOS)
//
//  Created by Natasa Zupanski on 4/11/21.
//

import SwiftUI

struct TabbedView: View {
    // If we do this, initating the ColonyData here may be best.
    var timer: ColonyTimer
    
    var body: some View {
        TabView {
            ListView(timer: {
                var timer = ColonyData.colonies[0]
                timer.colony.setCellAlive(row: 1, col: 1)
                timer.colony.setCellAlive(row: 2, col: 2)
                timer.colony.setCellAlive(row: 3, col: 3)
                return timer
            }())
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
        TabbedView(timer: {
            var timer = ColonyData.colonies[0]
            timer.colony.setCellAlive(row: 1, col: 1)
            timer.colony.setCellAlive(row: 2, col: 2)
            timer.colony.setCellAlive(row: 3, col: 3)
            return timer
        }())
    }
}
