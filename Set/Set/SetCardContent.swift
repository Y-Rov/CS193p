//
//  SetCardContent.swift
//  Set
//
//  Created by user on 3/12/23.
//

import Foundation

struct SetCardContent {
    let numberOfShapes: Int
    let shading: String
    let color: String
    let shape: String
}

extension SetCardContent: Equatable {
    static func == (lhs: SetCardContent, rhs: SetCardContent) -> Bool {
        var constantFeaturesCount = 0, differFeaturesCount = 0
        constantFeaturesCount += lhs.numberOfShapes == rhs.numberOfShapes ? 1 : 0
        differFeaturesCount += lhs.numberOfShapes != rhs.numberOfShapes ? 1 : 0
        constantFeaturesCount += lhs.shape == rhs.shape ? 1 : 0
        differFeaturesCount += lhs.shape != rhs.shape ? 1 : 0
        constantFeaturesCount += lhs.shading == rhs.shading ? 1 : 0
        differFeaturesCount += lhs.shading != rhs.shading ? 1 : 0
        constantFeaturesCount += lhs.color == rhs.color ? 1 : 0
        differFeaturesCount += lhs.color != rhs.color ? 1 : 0
        
        return
            differFeaturesCount == 4 ||
            constantFeaturesCount == 1 && differFeaturesCount == 3 ||
            constantFeaturesCount == 2 && differFeaturesCount == 2 ||
            constantFeaturesCount == 3 && differFeaturesCount == 1
    }
}
