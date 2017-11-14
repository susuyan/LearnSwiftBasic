//
//  main.swift
//  LearnSwiftForErrorHandling
//
//  Created by susuyan on 2017/11/14.
//  Copyright © 2017年 susuyan. All rights reserved.
//

import Foundation

print("Hello, World!")

/*
 错误处理是响应错误以及从错误中恢复的过程。
 Swift 提供了在运行时对可恢复错误的抛出、捕获、传递和操作的一等公民支持
 
 某些操作无法保证总是执行完所有代码或总是生成有用的结果。可选类型可用来表示值缺失，
 但是当某个操作失败时，最好能得知失败的原因，从而可以作出相应的应对
 
 */

// MARK: - 表示并抛出错误
/*
 在swift中，错误用符合Error协议的类型的值来表示，
 这个空协议表明该类型可以用于错误处理
 
 抛出一个错误可以让你表明有意外情况发生，导致正常的执行流程无法继续执行
 抛出错误使用throw 关键字
 */
enum VendingmachineError: Error {
    case invalidSelection
    case insufficinentFunds(coinsNeeded: Int)
    case outOfStock
}

//throw VendingmachineError.insufficinentFunds(coinsNeeded: 5)

// MARK: - 处理错误
/*
 某个错误被抛出时，附近的某部分代码必须负责处理这个错误
 Swift 中有4种处理错误的方式：
 你可以把函数抛出的错误传递给调用此函数的代码、用do-catch语句处理错误
 将错误作为可选类型狐狸、或者断言此错误根本不会发生
 */
/*
 为了标识出出错的地方，在调用一个能抛出错误的函数、方法或者构造器之前
 加上try关键字，或者try？或try！这种变体
 注：Swift中的错误处理并不涉及解除调用栈
 */

// MARK: - 用throwing函数传递错误
/*
 为了表示一个函数、方法或构造器可以抛出错误，在函数声明的参数列表之后加上throws关键字
 一个throwing函数可以在其内部抛出错误，并将错误传递到函数被调用时的作用域
 注：只有throwing函数可以传递错误。任何在某个非throwing函数内部抛出的错误只能在函数内部处理
 */

func canThrowErrors() throws -> String {
    return "error"
}
func cannotThrowErrors() -> String{
    return "error"
}

struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0
    func dispenseSnack(snack: String) {
        print("Dispensing \(snack)")
    }
    
    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingmachineError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingmachineError.outOfStock
        }
        guard item.price <= coinsDeposited else {
            throw VendingmachineError.insufficinentFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("Dispensing \(name)")
    }
}


let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]

func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}

/*
 throwing 构造器能像throwing函数一样传递错误
 */
struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}

// MARK: - 用Do-Catch处理错误
/*
 可以使用一个do-catch语句运行一段闭包代码来处理错误。
 如果在do子句中的代码抛出了一个错误，这个错误会与catch子句做匹配，从而决定哪条子句能处理它
 do {
 try expression
 statements
 } catch pattern 1 {
 statements
 } catch pattern 2 where condition {
 statements
 }
*/

var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
}catch VendingmachineError.invalidSelection {
    print("Invalid Selection.")
}catch VendingmachineError.outOfStock {
    print("Out of stock")
}catch VendingmachineError.insufficinentFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional\(coinsNeeded) coins.")
}

// MARK: - 将错误转换成可选值
/*
 可以使用try?通过将错误转成一个可选值来处理错误
 如果在评估try？表达式时一个错误被抛出，那么表达式的值就是nil
 */
func someThrowingFunction() throws -> Int {
    return 0
}

let x = try? someThrowingFunction()
let y: Int?
do {
    y = try someThrowingFunction()
} catch {
    y = nil
}

// MARK: - 禁用错误传递
/*
 有时你知道某个throwing 函数实际上在运行时是不会抛出错误的，
 在这种情况下，你可以在表达式前面写try！来禁用错误传递，这会把调用包装在一个不会有错误抛出的运行时断言中。
 如果真的抛出了错误，你会得到一个运行时错误
 */

// MARK: - 指定清理操作
/*
 可以使用defer语句在即将离开当前代码块时执行一系列语句。
 该语句让你能执行一些必要的清理工作，不管是以何种方式离开当前代码块的 --
 无论是由于抛出错误离开的，还是诸如return 或者break的语句
 
 例如，你可以用defer语句来确保文件描述符得以关闭以及手动分配的内存得以释放
 
 defer 语句将代码的执行延迟到当前的作用域退出之前
 */

//func processFile(filename: String)throws {
//    if exists(filename) {
//        let file = open(filename)
//        defer {
//            close(file)
//        }
//        while let line = try file.readline(){
//
//        }
//        //close(file)会在这里被调用，即作用域的最后
//
//    }
//}









