//
//  ViewModelBindable.swift
//  StarWars
//
//  Created by Silva Kirsimae on 24/02/2023.
//

protocol ViewModelBindable {
    associatedtype ViewModelType: ReactiveConnectable

    func bind(to viewModel: ViewModelType)
    func bind(viewModel input: ViewModelType.Input)
    func bind(viewModel output: ViewModelType.Output)
}

extension ViewModelBindable {
    func bind(to viewModel: ViewModelType) {
        bind(viewModel: viewModel.input)
        bind(viewModel: viewModel.output)
    }
}

