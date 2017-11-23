//
//  main.swift
//  LearnSwiftForGenerics
//
//  Created by susuyan on 2017/11/21.
//  Copyright © 2017年 susuyan. All rights reserved.
//

import Foundation

print("Hello, World!")

/*
 泛型代码可以让你写出根据自我需求定义、适用于任何类型的，灵活且可重用的函数和类型。
 它可以让你避免重复的代码，用一种清晰和抽象的方式来表达代码的意图
 */


func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)

print("someInt is now\(someInt), and anotherInt is now \(anotherInt)")

func swapTwoValues<T>(_ a: inout T,_ b: inout T ){
    let temporaryA = a
    a = b
    b = temporaryA
}

swapTwoValues(&someInt, &anotherInt)

print("someInt is now\(someInt), and anotherInt is now \(anotherInt)")


var someString = "hello"
var anotherString = "world"
swapTwoValues(&someString, &anotherString)

// MARK: -  类型参数
/*
 在上面的 swapTowValues 例子中，占位类型 T 是一种类型参数的示例
 类型参数指定并命名为一个占位类型，并且紧随在函数后面，使用一堆尖括号括起来（<T>）
 可支持多个类型参数，命名在尖括号中，用逗号分开
 
 */

// MARK: -  命名类型参数
/*
 在简单的情况下，泛型类型或泛型类型函数需要指定一个占位类型
 通常用一单个字母 T 来命名类型参数
 不过，你可以使用任何有效的标识来作为参数类型参数名 （驼峰命名，eg:KeyType , ValueType）
 */

// 非泛型版本的栈
struct IntStack {
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    
}
// 泛型版本的栈
struct Stack <T> {
    var items = [T]()
    mutating func push(_ item: T){
        items.append(item)
    }
    mutating func pop() -> T {
        
        return items.removeLast()
    }
}

// MARK: - 类型约束
/*
  类型约束制定了一个必须继承自指定类的类型参数，或者遵循一个特定的协议或协议构成
 
 */

func findIndex(ofString valueToFind:String, in array:[String]) -> Int? {
    
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findIndex(ofString: "llama", in: strings) {
    print("The index of llama is \(foundIndex)")
}

//func findIndex<T>(of valueToFind: T, in array:[T]) -> Int? {
//    for (index, value) in array.enumerated() {
//        if value == valueToFind { // 不是所有的 Swift 中的类型都可以用 == 进行比较
//            return index
//        }
//    }
//    return nil
//}

func findIndex<T:Equatable>(of valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind { // 不是所有的 Swift 中的类型都可以用 == 进行比较
            return index
        }
    }
    return nil
}

if let fundIndex = findIndex(of: "parakeet", in: strings) {
    print("The index of parakeet is \(fundIndex)")
}

// MARK: - 关联类型
/*
 当定义一个协议时，有的时候声明一个或多个关联类型作为协议定义的一部分是非常有用的。
 一个关联类型作为协议的一部分, 给定了类型的一个占位名（或别名）
 作用于关联类型上实际类型在协议被实现前是不需要指定的
 关联类型被指定为 typealias 关键字
 */
protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int {get}
    subscript(i: Int) -> Item {get}
}

//  非泛型版本
struct IntStack1: Container {
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    
    typealias ItemType = Int
    mutating func append(_ item: Int) {
        self.push(item)
    }
    
    var count: Int{
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}

//  泛型版本
struct Stack1<Element>: Container {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    
    mutating func append(_ item: Element) {
        self .push(item)
    }
    
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
    
}


// MARK: - Where 语句
/*
 类型约束能够确保类型符合泛型函数或类的定义约束
 一个 where 语句能够使一个关联类型遵循一个特定的协议
 以及那个特定的类型参数和关联类型可以是相同的
 
 */
func allItemsMatch<C1:Container, C2:Container> (_ someContainer: C1, _ anotherContainer: C2) -> Bool
    where C1.Item == C2.Item, C1.Item: Equatable {

        if someContainer.count != anotherContainer.count {
            return false
        }
        
        for i in 0 ..< someContainer.count {
            if someContainer[i] != anotherContainer[i] {
                return false
            }
        }
        
        return true
}

var stackOfStrings = Stack1<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")

var arrayOfStrings = ["uno", "dos", "tres"]

//if allItemsMatch(stackOfStrings, arrayOfStrings) {
//    print("all items")
//}else {
//    print("Not all ")
//}

extension Stack1 where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        
        return topItem == item
    }
}

// TODO: - where 语句还得熟悉下




