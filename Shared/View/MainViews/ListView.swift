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
    //@EnvironmentObject var timer: ColonyTimer
//    @State var placeholder = 0
    @State private var isPaused = true
    @EnvironmentObject var colonyData : ColonyData
    /*var nativeTimer : Publishers.Autoconnect<Timer.TimerPublisher> {
        Timer.publish(every: self.speed, on: .main, in: .common).autoconnect()
    }*/
    @State var nativeTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private var buttonImage: Image {
        if isPaused == true {
            return Image("Play button")
        }
        return Image("Pause button")
    }
    
    func stopTimer() {
        self.nativeTimer.upstream.connect().cancel()
    }
    
    func startTimer() {
        self.nativeTimer = Timer.publish(every: speed, on: .main, in: .common).autoconnect()
    }
    
    func play(){
        isPaused.toggle()
        if !isPaused {
            //timer.startClockTimer(timerSpeed: speed)
            startTimer()
        } else {
            //timer.killClockTimer()
            stopTimer()
        }
    }
    
    /*func wrap() {
        
        //timer.colony.wrap = true
        colonyData.colonies[colonyData.selectedIndex].wrap = true
    }*/
    
    var body: some View {
        VStack() {
            Toggle(isOn: $colonyData.colonies[colonyData.selectedIndex].wrap) {
                Text("Wrap")
                
            }
            
            HStack {
                Button(action: {play()}) {
                    Image(isPaused ? "Play button" : "Pause button")
                        .resizable()
                        .frame(width: 26.0, height: 30)
                }

                //Text("\(timer.tickCount)")
                Text("\(colonyData.colonies[colonyData.selectedIndex].generationNumber)")
                    .font(.largeTitle)
                    .onReceive(nativeTimer) { input in
                        if !colonyData.colonies[colonyData.selectedIndex].wrap {
                            colonyData.colonies[colonyData.selectedIndex].evolve()
                        } else {
                            colonyData.colonies[colonyData.selectedIndex].evolveWrap()
                        }
                    }
                //TextField(colonyData.colonies[colonyData.selectedIndex].name, text: $colonyData.colonies[colonyData.selectedIndex].name)
            }
                        
            VStack(alignment: .leading, spacing: 0.0){
                Text("Speed: \(String(String(speed).prefix(4)))s")
                Slider(value: $speed, in: 0.5...20, step: 0.01, onEditingChanged: { _ in //timer.timerSliderChanged(speed)
                    if !isPaused {
                        stopTimer()
                        startTimer()
                        //nativeTimer = Timer.publish(every: speed, on: .main, in: .common).autoconnect()
                        
                    }
                    
                }
                    //stopTimer()
                    //startTimer()
                )

                Text("Details:")
                    .font(.title2)
                    .bold()
                    //.padding(.bottom, -1.0)
                //Text("Name: \(timer.colony.name)")
                HStack(spacing: 0.0) {
                    Text("Name: ")
                    TextField(colonyData.colonies[colonyData.selectedIndex].name, text: $colonyData.colonies[colonyData.selectedIndex].name)
                }
                Text("Locked: \(String(colonyData.colonies[colonyData.selectedIndex].locked))")
                //Text("Locked: \(String(timer.colony.locked))")
                //Text("Original Template: \(timer.colony.originalTemplate)")
                Text("Original Template: \(colonyData.colonies[colonyData.selectedIndex].originalTemplate)")
            }
            .padding(.vertical)
            
            //ScrollView {
            VStack (alignment: .leading){
                Text("Templates:")
                    .font(.title2)
                    .bold()
                
                TemplateGrid(/*timer: timer, */colony: .constant(Colony(size: 60)), enableNew: true)//colonyData.colonies[colonyData.selectedIndex], enableNew: true)
            }
            //}
            
            
            
        }
        .padding(19.0)
        .onAppear {
            stopTimer()
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            /*.environmentObject({ () -> ColonyTimer in
                //let timer = ColonyData().timers[0]
                let timer = ColonyData().timersTwo[0]
                timer.colony.setCellAlive(row: 1, col: 1)
                timer.colony.setCellAlive(row: 2, col: 2)
                timer.colony.setCellAlive(row: 3, col: 3)
                return timer
            }())*/
            .environmentObject(ColonyData())
    }
}
