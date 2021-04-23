//
//  Conways_iPadApp.swift
//  Shared
//
//  Created by Natasa Zupanski on 4/9/21.
//

import SwiftUI

@main
struct Conways_iPadApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject({ () -> ColonyTimer in
                    let timer = ColonyData.colonies[0]
                    timer.colony.setCellAlive(row: 1, col: 1)
                    timer.colony.setCellAlive(row: 2, col: 2)
                    timer.colony.setCellAlive(row: 3, col: 3)
                    return timer
                }())
            //NewColony(newTimer: ColonyTimer(Colony(size: 60)))
            /*ColonyView()
                .environmentObject({ () -> ColonyTimer in
                    let timer = ColonyData.colonies[0]
                    timer.colony.setCellAlive(row: 1, col: 1)
                    timer.colony.setCellAlive(row: 2, col: 2)
                    timer.colony.setCellAlive(row: 3, col: 3)
                    return timer
                }())*/
            //TemplateGrid(templates: [Colony(size: 60), Colony(size: 60), Colony(size: 60)])
        }
    }
}
