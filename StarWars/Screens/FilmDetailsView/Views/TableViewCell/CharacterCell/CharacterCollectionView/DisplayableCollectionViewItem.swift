//
//  DisplayableCollectionViewItem.swift
//  StarWars
//
//  Created by Silva Kirsimae on 28/02/2023.
//

import Foundation

//class DisplayableCollectionViewItem: Equatable {
//    static func == (lhs: DisplayableCollectionViewItem, rhs: DisplayableCollectionViewItem) -> Bool {}
//    
////    var label: String
////
////    init(label: String) {
////        self.label = label
////    }
////
////    static func == (lhs: DisplayableCollectionViewItem, rhs: DisplayableCollectionViewItem) -> Bool {
////        return lhs.label == rhs.label
////    }
//}

class DisplayableCharacter {
    var character: Person
    
    init(character: Person) {
        self.character = character
    }
}
