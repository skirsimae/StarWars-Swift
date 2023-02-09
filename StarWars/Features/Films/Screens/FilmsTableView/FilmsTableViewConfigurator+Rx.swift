//
//  FilmsTableViewConfigurator+Rx.swift
//  StarWars
//
//  Created by Silva Kirsimae on 09/02/2023.
//

import RxCocoa
import RxSwift

extension Reactive where Base: FilmsTableViewConfigurator {
    var dataSource: Binder<FilmsTableViewConfigurator.DataSource> {
        return Binder(self.base) { tableConfigurator, dataSource in
            tableConfigurator.dataSource = dataSource
        }
    }

    var reloadDataSource: PublishSubject<Void> {
        return base.onReloadDataSource
    }
}


