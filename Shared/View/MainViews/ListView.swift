//
//  ListView.swift
//  Conways_iPad (iOS)
//
//  Created by Clara Dutton on 4/9/21.
//

import SwiftUI

struct ListView: View {
    @State private var isTrue = true
    @State private var speed: Double = 0
    @State var colony: Colony
//    @State var placeholder = 0
    @State private var isPaused = true
    
    private var buttonImage: Image {
        if isPaused == true{
            return Image("Play button")
        }
        return Image("Pause button")
    }
    
    var body: some View {
        VStack() {
            Toggle(isOn: $isTrue) {
                Text("Wrap")
            }
            
            HStack {
                Button(action: {isPaused.toggle()}) {
                    buttonImage
                        .resizable()
                        .frame(width: 26.0, height: 30)
                }

                Text("TIME")
                    .font(.largeTitle)
            }
//            .background(Color.secondary)
                        
            VStack(alignment: .leading){
                Text("Speed: \(Int(speed))")
                Slider(value: $speed, in: 0...100.0)

                Text("Details:")
                    .font(.title2)
                    .bold()
                    .padding(.bottom, -1.0)
                Text("Name: \(colony.name)")
                Text("Locked: \(String(colony.locked))")
                Text("Original Template: \(colony.originalTemplate)")
            }
            .padding(.vertical)
            
            VStack (alignment: .leading){
                Text("Templates:")
                    .font(.title2)
                    .bold()
                
                TemplateGrid(templates: [Colony(size: 60), Colony(size: 60), Colony(size: 60), Colony(size: 60)], colony: Colony(size: 60), enableNew: true)
            }
            
            
            
        }
        .padding(19.0)

    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(colony: {
            var colony = ColonyData.colonies[1]
            colony.setCellAlive(row: 1, col: 1)
            colony.setCellAlive(row: 2, col: 2)
            colony.setCellAlive(row: 3, col: 3)
            return colony
        }())
    }
}
