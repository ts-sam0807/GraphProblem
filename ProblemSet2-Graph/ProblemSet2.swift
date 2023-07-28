//
//  ProblemSet2.swift
//  Swift-AGDS
//
//  Created by Ts SaM on 27/7/2023.
//

import Foundation

// Cyclic Permutation (DFS)
func findCycles(_ permutation: [Int]) -> Int {
    var visited = [Bool](repeating: false, count: permutation.count + 1)
    var cycles = 0

    for i in 1...permutation.count {
        if !visited[i] {
            var current = i
            repeat {
                visited[current] = true
                current = permutation[current - 1]
            } while current != i
            cycles += 1
        }
    }
    return cycles
}

func cyclicPermutation() {
    let t = Int(readLine()!)!
    var result: Int

    for _ in 0..<t {
        let _ = readLine() // Ignore the size N as it's not needed in this algorithm
        let permutation = readLine()!.split(separator: " ").map { Int($0)! }
        result = findCycles(permutation)
        print("Result : \(result)");
    }
}

//----------------------------------------




// Repeating Sequence
func sumOfPowerDigits(_ number: Int, _ power: Int) -> Int {
    var sum = 0
    var num = number
    while num > 0 {
        let digit = num % 10
        sum += Int(pow(Double(digit), Double(power)))
//        print(sum)
        num /= 10
    }
    return sum
}

func countNonRepeatingNumbers(_ initialNumber: Int, _ power: Int) -> Int {
    var numbersSet = Set<Int>()
    var currentNumber = initialNumber

    while !numbersSet.contains(currentNumber) {
        numbersSet.insert(currentNumber)
        currentNumber = sumOfPowerDigits(currentNumber, power)
//        print(currentNumber)
    }

    let repeatingNumber = currentNumber
    var count = 0

    currentNumber = initialNumber
//    Until get the result number
    while currentNumber != repeatingNumber {
        count += 1
        currentNumber = sumOfPowerDigits(currentNumber, power)
    }
    return count
}

func repeatingSequence() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let A = input[0]
    let P = input[1]

    let nonRepeatingCount = countNonRepeatingNumbers(A, P)
    print("Non Repeat Count : \(nonRepeatingCount)")
}

//----------------------------------------


// Find Judge
func findJudgeHelper(_ N: Int, _ trust: [[Int]]) -> Int {
    var trustCounts = [Int](repeating: 0, count: N + 1)

    for t in trust {
        let a = t[0]
        let b = t[1]
        trustCounts[a] -= 1 // non-trust
        trustCounts[b] += 1 // trust
    }

    for i in 1...N {
        if trustCounts[i] == (N - 1) {
            return i
        }
    }
    return -1 // No Result
}

func findJudge() {
    let N2 = 2
    let N3 = 3
    
    let trust1 = [[1,2]]
    let trust2 = [[1,3],[2,3]]
    let trust3 = [[1,3],[2,3],[3,1]]
    
    let townJudge1 = findJudgeHelper(N2, trust1)
    let townJudge2 = findJudgeHelper(N3, trust2)
    let townJudge3 = findJudgeHelper(N3, trust3)
    
    print("Town Judge 1 : \(townJudge1)")
    print("Town Judge 2 : \(townJudge2)")
    print("Town Judge 3 : \(townJudge3)")
}

//----------------------------------------

//    1 2 3
// 1  1 1 0
// 2  1 1 0
// 3  0 0 1
// Find Circle Number
// Adjecncy Matrix & DFS
func findCircleNumHelper(_ isConnected: [[Int]]) -> Int {
    let n = isConnected.count
    var visited = [Bool](repeating: false, count: n)
    var provinces = 0

    func dfs(_ u: Int) {
        visited[u] = true
        for v in 0..<n {
//            print(visited[v])
            if isConnected[u][v] == 1 && visited[v] == false {
//                print(v)
                dfs(v)
            }
        }
    }

    for u in 0..<n {
        if !visited[u] {
            provinces += 1
            dfs(u)
        }
    }
    return provinces
}

func findCircle() {
    let isConnected = [[1, 1, 0], [1, 1, 0], [0, 0, 1]]
    let circleNums = findCircleNumHelper(isConnected)
    print("Circle Numbers : \(circleNums)")
}

//----------------------------------------

// Find Center
func findCenterHelper(_ edges: [[Int]]) -> Int {
    var nodes = [Int](repeating: 0, count: edges.count + 2)
    for edge in edges {
        let u = edge[0]
        let v = edge[1]
        nodes[u] += 1
        nodes[v] += 1
    }

    for i in 1..<nodes.count {
//        print(nodes[i])
        if nodes[i] == edges.count {
            return i
        }
    }
    return -1
}

func findCenter() {
    let edges = [[1, 2], [2, 3], [4, 2]]
    let centerNode = findCenterHelper(edges)
    print("Center Node : \(centerNode)")
}
//----------------------------------------
