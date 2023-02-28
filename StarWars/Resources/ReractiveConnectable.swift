//
//  ReractiveConnectable.swift
//  StarWars
//
//  Created by Silva Kirsimae on 24/02/2023.
//

protocol ReactiveConnectable {
    associatedtype Input
    associatedtype Output

    var input: Input { get }
    var output: Output { get }

    func transform(input: Input) -> Output
}
