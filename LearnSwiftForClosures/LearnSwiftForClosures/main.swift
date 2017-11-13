//
//  main.swift
//  LearnSwiftForClosures
//
//  Created by susuyan on 2017/11/13.
//  Copyright © 2017年 susuyan. All rights reserved.
//

import Foundation

print("Hello, World!")

/*
 闭包是自包含的函数代码块，可以在代码中被传递和使用。（类似Block）
 闭包可以捕获和存储其所在上下文中任意常量和变量的引用。
 这就是所谓的闭合并包裹着这些常量和变量俗称闭包
*/

/*
 闭包采取的三种形式
 全局函数是一个有名字但不会捕获任何值得闭包
 嵌套函数是一个有名字并可以捕获其封闭函数域内值得闭包
 闭包表达式是一个利用轻量级语法所写的可以捕获其上下文中变量或常量值得匿名闭包
 */

/*
 闭包表达式语法
 { (paramertes)->returnType in
   statements
 }
 */

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}
var reverseNames = names.sorted(by: backward)

reverseNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})


// MARK: - 尾随闭包
/*
 如果您需要将一个很长的闭包表达式作为最后一个参数传递给函数，可以使用尾随闭包来增加函数的可读性
 尾随闭包是一个书写在函数括号之后的闭包表达式，函数支持将其作为最后一个参数调用
 */
func someFunctionThatTakesAClosure(closure:()->()){
    
}
//以下是不使用尾随闭包进行函数调用
someFunctionThatTakesAClosure (closure: {
    
})

//以下是使用尾随闭包进行函数调用
someFunctionThatTakesAClosure {
    //闭包主体
}

let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]

let strings = numbers.map {
    (number) -> String in
    var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    }while number > 0
    
    return output
}
print(strings)

// MARK: - 捕获值（Capturing Values）
/*
 闭包可以在其定义的上下文中捕获常量或变量
 即使定义这些常量或变量的原域已经不存在，闭包仍然可以在闭包函数体内引用和修改这些值
 
 */

func makeIncrementor(forIncrement amount:Int) ->() ->Int {
    var runningTotal = 0
    func incrementor() -> Int {
        runningTotal += amount
        
        return runningTotal
    }
    
    return incrementor
}

let incrementByTen = makeIncrementor(forIncrement: 10)

print(incrementByTen())
print(incrementByTen())

let incrementBySeven = makeIncrementor(forIncrement: 7)
print(incrementBySeven())
print(incrementByTen())

// MARK: - 闭包是引用类型
/*
 无论您将函数、闭包赋值给一个常量还是变量，您实际上都是将常量、变量的值设置为对应函数/闭包的引用
 */


//MARK: - Escaping Closures
var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

func someFunctionWithNoneescapingClosure(closure: () -> Void) {
    closure()
}


class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure {
            self.x = 100
        }
        someFunctionWithNoneescapingClosure {
            x = 200
        }
    }
    
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)

completionHandlers.first?()
print(instance.x)

// MARK: - Autoclosures

var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)

let customerProvider = {customersInLine.remove(at: 0)}

print(customersInLine.count)

print("Now serving \(customerProvider())!")
print(customersInLine.count)

func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}

serve { () -> String in
    customersInLine.remove(at: 0)
}



































