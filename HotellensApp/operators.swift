
//
//  operators.swift
//  HotellensApp
//
//  Created by Tom Jaster on 11/02/15.
//  Copyright (c) 2015 Hotellens. All rights reserved.
//

import Foundation

infix operator => {associativity left}

// many to many
func => <T:SequenceType>(left:T,
    right:(T.Generator.Element)->T.Generator.Element)-> [T.Generator.Element] {
        var x:[T.Generator.Element] = []
        for (idx,item) in enumerate(left){
            x.append(right(item))
        }
        return x
}
func => <T:SequenceType, B>(left:T,
    right:(T.Generator.Element)->B)-> [B] {
        var x:[B] = []
        for (idx,item) in enumerate(left){
            x.append(right(item))
        }
        return x
}

func => <T:SequenceType, B:SequenceType>(left:T,
    right:(T.Generator.Element)->B.Generator.Element)-> [B.Generator.Element] {
        var x:[B.Generator.Element] = []
        for (idx,item) in enumerate(left){
            x.append(right(item))
        }
        return x
}
// one to one
func => <T>(left:T, right:(T)->T)->T{
    return right(left)
}
func => <T,B>(left:T, right:(T)->B)->B{
    return right(left)
}
func => (left:AEXMLDocument, right:(AEXMLDocument)->AEXMLElement)->AEXMLElement{
    return right(left)
}
// one to many
func => <T>(left:T, right:(T)->[T]) ->[T]{
    return right(left)
}
func => <T,B>(left:T, right:(T)->[B]) ->[B]{
    return right(left)
}

// many to one
func => <T:SequenceType, B>(left:T,
    right:(T)->B)-> B {
        return right(left)
}