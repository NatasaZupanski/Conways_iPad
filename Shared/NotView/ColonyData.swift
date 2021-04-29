//
//  ColonyData.swift
//  Conways_iPad (iOS)
//
//  Created by Clara Dutton on 4/11/21.
//

//
//  ColonyData.swift
//  TestingGitHub (iOS)
//
//  Created by Natasa Zupanski on 4/23/21.
//


import Foundation

class ColonyData : ObservableObject {
    @Published var colonies : [Colony]
    @Published var templates : [Colony]
    @Published var selectedIndex : Int
    
    @Published var timers : [ColonyTimer]
    
    var timersTwo : [ColonyTimer] {
        get {
            var timers = [ColonyTimer]()
            for colony in colonies {
                var timer = ColonyTimer(colony)
                timer.id = colony.id
                timers.append(timer)
            }
            return timers
        }
        set (newTimers) {
            for timer in newTimers {
                let index = colonies.firstIndex(where: {$0.id == timer.id})
                self.colonies[index!] = timer.colony
            }
        }
    }
    
    init() {
        self.colonies = [{
            var colony = Colony(size: 60)
            colony.setCellAlive(row: 0, col: 0)
            colony.setCellAlive(row: 0, col: 1)
            colony.setCellAlive(row: 0, col: 2)
            colony.setCellAlive(row: 0, col: 3)
            return colony
        }(), Colony(size: 60)]
        self.templates = [Colony(size: 60), Colony(size: 60), Colony(size: 60), Colony(size: 60)]
        self.selectedIndex = 0
        self.timers = [ColonyTimer(Colony(size: 60))]
    }
 }


/*import Foundation

struct ColonyData {
    static var colonies: [ColonyTimer] = [ColonyTimer(Colony(size: 60, name: "Test", originalTemplate: "Blank"))]
    /*static var templates: [ColonyTimer] = [ColonyTimer(Colony(size: 60, name: "Blank")), ColonyTimer(Colony(size: 60, name: "Basic")), ColonyTimer(Colony(size: 60, name: "Glider")), {
        var t = ColonyTimer(Colony(size: 60))
        t.colony.setCellAlive(row: 1, col: 1)
        return t
    }() ]*/
    static var templates: [Colony] = [Colony(size: 60, name: "Blank"), Colony(size: 60, name: "Basic"), Colony(size: 60, name: "Glider"), {
        var t = Colony(size: 60)
        t.setCellAlive(row: 1, col: 1)
        return t
    }() ]
}*/
