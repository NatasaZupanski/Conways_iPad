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

class ColonyData : ObservableObject {//, Codable {
    @Published var colonies : [Colony]
    @Published var templates : [Colony]
    @Published var selectedIndex : Int
    
    /*@Published var timers : [ColonyTimer]
    
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
    }*/
    
    init() {
        self.colonies = [{
            var colony = Colony(size: 60)
            colony.name = "First Colony"
            return colony
        }()]
        self.templates = [{
            var blank = Colony(size: 60)
            blank.name = "Blank"
            return blank
        }(), {
            var basic = Colony(size: 60)
            basic.name = "Basic"
            basic.setCellAlive(row: 29, col: 29)
            basic.setCellAlive(row: 29, col: 30)
            basic.setCellAlive(row: 29, col: 31)
            basic.setCellAlive(row: 30, col: 30)
            return basic
        }(), {
            var glider = Colony(size: 60)
            glider.name = "Glider"
            glider.setCellAlive(row: 10, col: 8)
            glider.setCellAlive(row: 10, col: 9)
            glider.setCellAlive(row: 10, col: 10)
            glider.setCellAlive(row: 11, col: 10)
            glider.setCellAlive(row: 12, col: 9)
            return glider
        }(), {
            var gliderGun = Colony(size: 60)
            gliderGun.name = "Glider Gun"
            gliderGun.setCellAlive(row: 5, col: 1)
            gliderGun.setCellAlive(row: 6, col: 2)
            gliderGun.setCellAlive(row: 5, col: 11)
            gliderGun.setCellAlive(row: 6, col: 11)
            gliderGun.setCellAlive(row: 7, col: 11)
            gliderGun.setCellAlive(row: 8, col: 12)
            gliderGun.setCellAlive(row: 9, col: 13)
            gliderGun.setCellAlive(row: 9, col: 14)
            gliderGun.setCellAlive(row: 4, col: 12)
            gliderGun.setCellAlive(row: 3, col: 13)
            gliderGun.setCellAlive(row: 3, col: 14)
            gliderGun.setCellAlive(row: 6, col: 15)
            gliderGun.setCellAlive(row: 4, col: 16)
            gliderGun.setCellAlive(row: 8, col: 16)
            gliderGun.setCellAlive(row: 5, col: 17)
            gliderGun.setCellAlive(row: 6, col: 17)
            gliderGun.setCellAlive(row: 7, col: 17)
            gliderGun.setCellAlive(row: 6, col: 18)
            gliderGun.setCellAlive(row: 3, col: 21)
            gliderGun.setCellAlive(row: 4, col: 21)
            gliderGun.setCellAlive(row: 5, col: 21)
            gliderGun.setCellAlive(row: 5, col: 22)
            gliderGun.setCellAlive(row: 4, col: 22)
            gliderGun.setCellAlive(row: 3, col: 22)
            gliderGun.setCellAlive(row: 2, col: 23)
            gliderGun.setCellAlive(row: 6, col: 23)
            gliderGun.setCellAlive(row: 6, col: 25)
            gliderGun.setCellAlive(row: 7, col: 25)
            gliderGun.setCellAlive(row: 1, col: 25)
            gliderGun.setCellAlive(row: 2, col: 25)
            gliderGun.setCellAlive(row: 3, col: 35)
            gliderGun.setCellAlive(row: 4, col: 36)
            return gliderGun
        }()]
        self.selectedIndex = 0
        //self.timers = [ColonyTimer(Colony(size: 60))]
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
