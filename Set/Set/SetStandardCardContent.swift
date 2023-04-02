//
//  SetCardContent.swift
//  Set
//
//  Created by user on 3/12/23.
//

import Foundation

protocol SetMadeCheck {
    func checkIfCardMakesSet(other: SetStandardCardContent) -> (constant: Int, differ: Int)
}

struct SetStandardCardContent {
    let numberOfShapes: Int
    let shading: String
    let color: String
    let shape: String
}

extension SetStandardCardContent: SetMadeCheck {
    func checkIfCardsMakeSet(second: SetStandardCardContent, third: SetStandardCardContent) -> Bool {
        let numberOfShapes = Set([numberOfShapes, second.numberOfShapes, third.numberOfShapes])
        let shadings = Set([shading, second.shading, third.shading])
        let colors = Set([color, second.color, third.color])
        let shapes = Set([shape, second.shape, third.shape])
        
        return (numberOfShapes.count == 1 || numberOfShapes.count == 3) &&
            (shadings.count == 1 || shadings.count == 3) &&
            (colors.count == 1 || colors.count == 3) &&
            (shapes.count == 1 || shapes.count == 3)
    }
    
    func checkIfCardMakesSet(other: SetStandardCardContent) -> (constant: Int, differ: Int) {
        var constantFeaturesCount = 0, differFeaturesCount = 0
        constantFeaturesCount += numberOfShapes == other.numberOfShapes ? 1 : 0
        differFeaturesCount += numberOfShapes != other.numberOfShapes ? 1 : 0
        constantFeaturesCount += shading == other.shading ? 1 : 0
        differFeaturesCount += shading != other.shading ? 1 : 0
        constantFeaturesCount += color == other.color ? 1 : 0
        differFeaturesCount += color != other.color ? 1 : 0
        constantFeaturesCount += shape == other.shape ? 1 : 0
        differFeaturesCount += shape != other.shape ? 1 : 0

        return (constantFeaturesCount, differFeaturesCount)
    }
}
