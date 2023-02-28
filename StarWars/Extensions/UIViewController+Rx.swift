//
//  UIViewController+Rx.swift
//  StarWars
//
//  Created by Silva Kirsimae on 24/02/2023.
//
import UIKit
import RxSwift
import RxCocoa

public extension Reactive where Base: UIViewController {
    
    var viewWillAppear: ControlEvent<Void> {
        let source = base.rx.methodInvoked(#selector(Base.viewWillAppear))
            .map { _ in }
      return ControlEvent(events: source)
    }
    
//    var viewWillAppear: Observable<Void> {
//        return methodInvoked(#selector(Base.viewWillAppear))
//            .map { _ in }
//    }

    var viewDidAppear: Observable<Void> {
        return methodInvoked(#selector(Base.viewDidAppear))
            .map { _ in }
    }

    var viewWillDisappear: Observable<Void> {
        return methodInvoked(#selector(Base.viewWillDisappear))
            .map { _ in }
    }

    var viewDidDisappear: Observable<Void> {
        return methodInvoked(#selector(Base.viewDidDisappear))
            .map { _ in }
    }
}
