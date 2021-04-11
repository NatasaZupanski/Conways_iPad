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
            /*ColonyView(colony: {
                var colony = Colony(size: 60)
                colony.setCellAlive(row: 1, col: 1)
                colony.setCellAlive(row: 2, col: 2)
                return colony
            }())*/
            //TemplateGrid(templates: [Colony(size: 60), Colony(size: 60), Colony(size: 60)])
        }
    }
}
