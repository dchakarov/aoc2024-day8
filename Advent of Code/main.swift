//
//  main.swift
//  No rights reserved.
//

import Foundation
import Algorithms

func main() {
    let fileUrl = URL(fileURLWithPath: "./aoc-input")
    guard let inputString = try? String(contentsOf: fileUrl, encoding: .utf8) else { fatalError("Invalid input") }
    
    let lines = inputString.components(separatedBy: "\n")
        .filter { !$0.isEmpty }

    var antenas: [Character: [(Int, Int)]] = [:]
    
    for i in 0..<lines.count {
        let line = Array(lines[i])
        for j in 0..<line.count {
            let char = line[j]
            if char == "." { continue }
            antenas[char, default: []].append((i, j))
        }
    }
    
    var allAntinodes: [(Int, Int)] = []
    
    for (_, positions) in antenas {
        positions.combinations(ofCount: 2).forEach { permutation in
            let antinodes = antinodes(position1: permutation[0], position2: permutation[1])
            allAntinodes.append(contentsOf: antinodes)
        }
    }
    
    let total = Set(allAntinodes
        .filter { $0.0 >= 0 && $0.1 >= 0 && $0.0 < lines.count && $0.1 < lines.count }
        .map { "\($0)" })
        .count
    
    print(total)
}

func antinodes(position1: (Int, Int), position2: (Int, Int)) -> [(Int, Int)] {
    let deltaX = position1.0 - position2.0
    let deltaY = position1.1 - position2.1
    
    let antinode1 = (position1.0 + deltaX, position1.1 + deltaY)
    let antinode2 = (position2.0 - deltaX, position2.1 - deltaY)
    
    return [antinode1, antinode2]
}

main()
