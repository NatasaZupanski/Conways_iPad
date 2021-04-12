//
//  ColonyData.swift
//  Conways_iPad (iOS)
//
//  Created by Clara Dutton on 4/11/21.
//

import Foundation

struct ColonyData {
    static var colonies: [Colony] = [Colony(size: 60, name: "Test", originalTemplate: "Blank")]
    static var templates: [Colony] = [Colony(size: 60, name: "Blank"), Colony(size: 60, name: "Basic"), Colony(size: 60, name: "Glider")]
}
