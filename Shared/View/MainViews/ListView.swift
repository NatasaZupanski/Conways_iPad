//
//  ListView.swift
//  Conways_iPad (iOS)
//
//  Created by Clara Dutton on 4/9/21.
//

import SwiftUI

struct ListView: View {
    @State private var isWrap = true
    @State private var speed: Double = 1
    @EnvironmentObject var timer: ColonyTimer
//    @State var placeholder = 0
    @State private var isPaused = true
    
    private var buttonImage: Image {
        if isPaused == true{
            return Image("Play button")
        }
        return Image("Pause button")
    }
    
    func play(){
        isPaused.toggle()
        if !isPaused {
            timer.startClockTimer(timerSpeed: speed)
        } else {
            timer.killClockTimer()
        }
    }
    
    func wrap() {
        
        timer.colony.wrap = true
    }
    
    var body: some View {
        VStack() {
            Toggle(isOn: $timer.colony.wrap) {
                Text("Wrap")
                
            }
            
            HStack {
                Button(action: {play()}) {
                    buttonImage
                        .resizable()
                        .frame(width: 26.0, height: 30)
                }

                Text("\(timer.tickCount)")
                    .font(.largeTitle)
            }
                        
            VStack(alignment: .leading){
                Text("Speed: \(Int(speed))")
                Slider(value: $speed, in: 1...50, step: 1, onEditingChanged: { _ in timer.timerSliderChanged(speed)}
                )

                Text("Details:")
                    .font(.title2)
                    .bold()
                    .padding(.bottom, -1.0)
                Text("Name: \(timer.colony.name)")
                Text("Locked: \(String(timer.colony.locked))")
                Text("Original Template: \(timer.colony.originalTemplate)")
            }
            .padding(.vertical)
            
            VStack (alignment: .leading){
                Text("Templates:")
                    .font(.title2)
                    .bold()
                
                TemplateGrid(timer: timer, enableNew: true)
            }
            
            
            
        }
        .padding(19.0
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            .environmentObject({ () -> ColonyTimer in
                let timer = ColonyData().timers[0]
                timer.colony.setCellAlive(row: 1, col: 1)
                timer.colony.setCellAlive(row: 2, col: 2)
                timer.colony.setCellAlive(row: 3, col: 3)
                return timer
            }())
            .environmentObject(ColonyData())
    }
}
