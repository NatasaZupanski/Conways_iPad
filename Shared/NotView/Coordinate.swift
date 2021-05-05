//
//  Coordinate.swift
//  Conways_iPad (iOS)
//
//  Created by Clara Dutton on 4/9/21.
//

import Foundation

struct Coordinate: CustomStringConvertible, Hashable, Identifiable, Codable {
    var id = UUID()
    let row: Int
    let col: Int
    var description: String {
        "";
    }

    init(_ row: Int, _ col: Int) {
        self.row = row
        self.col = col
    }

    static func makeCoors(data: [(row: Int, col: Int)]) -> [Coordinate] {
        data.map { Coordinate($0.row, $0.col) }
    }
}
