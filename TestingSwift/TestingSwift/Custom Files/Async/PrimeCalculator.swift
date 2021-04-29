//
//  PrimeCalculator.swift
//  TestingSwift
//
//  Created by Michael Isasi on 4/28/21.
//

import Foundation

struct PrimeCalculator {
    
    @discardableResult static func calculateProgress(upTo max: Int, completion: @escaping ([Int]) -> Void) -> Progress {
        // create a Progress object that counts up to our maximum number
        let progress = Progress(totalUnitCount: Int64(max))
        
        DispatchQueue.global().async {
            guard max > 1 else {
                completion([])
                return
            }
            
            var sieve = [Bool](repeating: true, count: max)
            sieve[0] = false
            sieve[1] = false
            
            // add 2 to our progress counter, because we already went through 0 and 1
            progress.completedUnitCount += 2
            
            for number in 2 ..< max {
                // every time we've checked one number, add 1 to our completed unit count
                progress.completedUnitCount += 1
                
                if sieve[number] == true {
                    for multiple in stride(from: number * number, to: sieve.count, by: number) {
                        sieve[multiple] = false
                    }
                }
            }
            
            let primes = sieve.enumerated().compactMap { $1 == true ? $0 : nil }
            completion(primes)
        }
        
        // send back the Progress object
        return progress
    }
    
    static func calculateStreaming(upTo max: Int, completion: @escaping (Int) -> Void) {
        DispatchQueue.global().async {
            guard max > 1 else {
                return
            }
            
            var sieve = [Bool](repeating: true, count: max)
            sieve[0] = false
            sieve[1] = false
            
            for number in 2 ..< max {
                if sieve[number] == true {
                    for multiple in stride(from: number * number, to: sieve.count, by: number) {
                        sieve[multiple] = false
                    }
                    
                    completion(number)
                }
            }
        }
    }
    
    static func syncCalculate(upTo max: Int) -> [Int] {
        guard max > 1 else {
            return []
        }
        
        var sieve = [Bool](repeating: true, count: max)
        sieve[0] = false
        sieve[1] = false
        
        for number in 2 ..< max {
            if sieve[number] == true {
                for multiple in stride(from: number * number, to: sieve.count, by: number) {
                    sieve[multiple] = false
                }
            }
        }
        let primes = sieve.enumerated().compactMap { $1 == true ? $0 : nil }
        return primes
    }
}


