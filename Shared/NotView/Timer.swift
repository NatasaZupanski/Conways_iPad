//
//  Timer.swift
//  Conways_iPad (iOS)
//
//  Created by Clara Dutton on 4/21/21.
//

import Foundation
import Combine

class ColonyTimer: ObservableObject, Identifiable{
    var clockTimer: Timer!
    var timerInterval = 0.1
    @Published var tickCount: Int = 0
    @Published var colony: Colony
    let id = UUID()
    
    init (_ c: Colony){
        colony = c
    }
    
    func getColony() -> Colony{
        return colony
    }
    
    func startClockTimer(timerSpeed: Double){
        if clockTimer != nil{
            killClockTimer()
        }
        timerInterval = timerSpeed / 10.0
        clockTimer = Timer.scheduledTimer(timeInterval: timerInterval , target: self, selector: #selector(tick), userInfo: nil, repeats: true)
    }
    
    func killClockTimer(){
        if let ct = clockTimer {
            ct.invalidate()
            clockTimer = nil
            //colony.clear()
        }
    }
    
    func resetTime(){
        killClockTimer()
        tickCount = 0
    }
    
    @objc func tick (){
        tickCount += 1
        colony.evolve()
    }
}
