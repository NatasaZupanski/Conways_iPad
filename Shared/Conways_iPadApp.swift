//
//  Conways_iPadApp.swift
//  Shared
//
//  Created by Natasa Zupanski on 4/9/21.
//

// Total bugs:
//      1. Adding doesn't immediately go back to the colonyView. Hitting cancel afterwards does.
//      2. Lag; evolving lags the program
//      3. Error appears in debug w/ wrap: (2021-05-03 10:41:45.084614-0400 Conways_iPad[15677:1552060] invalid mode 'kCFRunLoopCommonModes' provided to CFRunLoopRunSpecific - break on _CFRunLoopError_RunCalledWithInvalidMode to debug. This message will only appear once per execution.)

// Fixed:
//      1. Bottom of TabView cuts out ; changed to PageTabStyle

import SwiftUI

@main
struct Conways_iPadApp: App {
    var colonyData = ColonyData()
    @Environment (\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                /*.environmentObject({ () -> ColonyTimer in
                    //let timer = colonyData.timers[0]
                    let timer = colonyData.timersTwo[0]
                    timer.colony.setCellAlive(row: 1, col: 1)
                    timer.colony.setCellAlive(row: 2, col: 2)
                    timer.colony.setCellAlive(row: 3, col: 3)
                    return timer
                }())*/
                .environmentObject(colonyData)
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
        .onChange(of: scenePhase) { newScenePhase in
            if newScenePhase == .background {
                if let encoded = try? JSONEncoder().encode(colonyData.colonies) {
                    let defaults = UserDefaults.standard
                    defaults.set(encoded, forKey: "colonies")
                }
                
                if let encoded = try? JSONEncoder().encode(colonyData.templates) {
                    let defaults = UserDefaults.standard
                    defaults.set(encoded, forKey: "templates")
                }
                
                if let encoded = try? JSONEncoder().encode(colonyData.selectedIndex) {
                    let defaults = UserDefaults.standard
                    defaults.set(encoded, forKey: "selectedIndex")
                }
                //objectWillChange.send()
                //profileData.updateToCodables()
                
            }
            if newScenePhase == .active {

                if let savedColonies = UserDefaults.standard.object(forKey: "colonies") as? Data, let loadedColonies = try? JSONDecoder().decode([Colony].self, from: savedColonies) {
                    colonyData.colonies = loadedColonies
                }
                
                if let savedTemplates = UserDefaults.standard.object(forKey : "templates") as? Data, let loadedTemplates = try? JSONDecoder().decode([Colony].self, from: savedTemplates) {
                    colonyData.templates = loadedTemplates
                }
                
                if let savedIndex = UserDefaults.standard.object(forKey : "selectedIndex") as? Data, let loadedIndex = try? JSONDecoder().decode(Int.self, from: savedIndex) {
                    colonyData.selectedIndex = loadedIndex
                }
                /*profileData.updateFromCodables()
            
                let storageRef = storage.reference()
                let extracts : [ProfileExtract] = profileData.profiles.map{ProfileExtract(profile: $0)}
                //let data = Data(extracts)
                //let uploadTask = storageRef.putData(data, metadata: nil)
                for extract in extracts {
                    let profileRef = storageRef.child("\(extract.id)")
                    do {
                        let encoder = JSONEncoder()
                        
                        let data = try encoder.encode(extract)
                        
                        /*let uploadTask = profileRef.putData(data, metadata: nil){ (metadata, error) in
                            guard let metadata = metadata else {
                                // Erorr occured
                                print("Error uploading")
                                return
                            }
                            //let size = metadata.size
                        }*/
                    }
                    catch {
                        // Do error here
                        print("Error encoding extract")
                    }
                    // Upload now
                }*/
                
            }
        }
    }
}
