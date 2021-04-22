//
//  ColonyData.swift
//  Conways_iPad (iOS)
//
//  Created by Clara Dutton on 4/11/21.
//

import Foundation

struct ColonyData {
    static var colonies: [ColonyTimer] = [ColonyTimer(Colony(size: 60, name: "Test", originalTemplate: "Blank"))]
    static var templates: [ColonyTimer] = [ColonyTimer(Colony(size: 60, name: "Blank")), ColonyTimer(Colony(size: 60, name: "Basic")), ColonyTimer(Colony(size: 60, name: "Glider")), {
        var t = ColonyTimer(Colony(size: 60))
        t.colony.setCellAlive(row: 1, col: 1)
        return t
    }() ]
}
