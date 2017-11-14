//
//  main.swift
//  LearnSwiftForNestedTypes
//
//  Created by susuyan on 2017/11/14.
//  Copyright © 2017年 susuyan. All rights reserved.
//

import Foundation

print("Hello, World!")

/*
 枚举场被用于为特定类或结构体实现某些功能，
 类似的，枚举可以方便的定义工具类或结构体，从而为某个复杂的类型所使用。
 为了实现这种功能，Swift允许你定义嵌套类型，可以在支持的类型中定义嵌套的枚举、类和结构体
 
 */

// MARK: - 嵌套类型实践
struct BlackjackCard {
    enum Suit: Character {
        case Spades = "♠️", Hearts = "❤", diamonds = "◇", Clubs = "♣️"
    }
    
    enum Rank: Int {
        case Two = 2,Three, Four,Five,Six,Seven,Eight,Nine,Ten
        case Jack, Queen, King, Ace
        struct Values {
            let first: Int, second: Int?
        }
        
        var  values: Values {
            switch self {
            case .Ace:
                return Values(first: 1, second: 1)
            case .Jack, .Queen, .King:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }

    }
    let rank: Rank, suit: Suit
    var description: String {
        var output = "suit is \(suit.rawValue),"
        output += "value is \(rank.values.first)"
        if let second = rank.values.second {
            output += " or \(second)"
        }
        
        return output
    }
    
}

let theAceOfSpades = BlackjackCard(rank: .Ace, suit: .Spades)
print("theAceOfSpades:\(theAceOfSpades.description)")


// MARK: - 引用嵌套类型
/*
 在外部引用嵌套类型时，在嵌套类型的类型名前加上外部类型的类型名作为前缀：
*/

let heartsSymbol = BlackjackCard.Suit.Hearts.rawValue

print(heartsSymbol)


