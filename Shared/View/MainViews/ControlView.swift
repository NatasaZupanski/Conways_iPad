//
//  ControlView.swift
//  Conways_iPad (iOS)
//
//  Created by Natasa Zupanski on 4/11/21.
//

import SwiftUI

struct ControlView: View {
    @EnvironmentObject var colonyData : ColonyData
    @State var show = false
    
    //@State var selectedID = UUID()
    
    var body: some View {
        GeometryReader { geo in
        List(colonyData.colonies) { colony in
            if colonyData.colonies[colonyData.selectedIndex].id == colony.id {
                VStack {
                    //HStack {
                        ZStack(alignment: .center) {
                    
                            Background(color: Color.gray.opacity(0.45))
                            //.animation(EaseInOut)
                            Text("\(colony.name)")
                                //.padding()
                                .cornerRadius(15.0)
                                
                        }
                        /*Image(systemName: "chevron.down.circle")
                            .rotationEffect(Angle(degrees: show ? 0 : 90))
                            .foregroundColor(.blue)
                            .onTapGesture {
                                self.show.toggle()
                            }
                        Spacer()
                    }
                    if show {
                        Template(colony: colony, width: Double(geo.size.width), name: .constant(" "))
                            .frame(height: geo.size.width)
                    }*/
                }
                    //.background(Background(color: Color.gray.opacity(0.5)))
            } else {
                ZStack {
                    Background(color: Color.white)
                        //.shadow(radius: 1)
                    Text("\(colony.name)")
                        //.background(Background(color: Color.white))
                        .onTapGesture {
                            makeSelected(colony)
                        }
                        /*.gesture(
                            LongPressGesture(minimumDuration: 2) {
                                .onEnded { _ in
                                    colonyData.colonies.remove(at: colonyData.colonies.firstIndex(where: {$0.id == colony.id}))
                                }
                            }
                        )*/
                        
                        
                }
                    //.animation()
            }
        }//.navigationBarItems(leading: EditButton())
        }
        /*Picker(colonyData.colonies[colonyData.selectedIndex].name, selection: $selectedID) {
            List(colonyData.colonies) { colony in
                Text("\(colony.name)").tag(colony.id)
            }
        }.onAppear {
            self.selectedID = colonyData.colonies[colonyData.selectedIndex].id
        }*/
    }
    
    func makeSelected(_ colony: Colony) {
        colonyData.selectedIndex = colonyData.colonies.firstIndex(where: {$0.id == colony.id})!
    }
    
    func delete(at offsets: IndexSet) {
        colonyData.colonies.remove(atOffsets: offsets)
    }
}

struct ControlView_Previews: PreviewProvider {
    static var previews: some View {
        ControlView()
            .environmentObject(ColonyData())
    }
}
