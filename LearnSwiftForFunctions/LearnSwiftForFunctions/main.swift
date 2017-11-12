//
//  main.swift
//  LearnSwiftForFunctions
//
//  Created by susuyan on 2017/11/10.
//  Copyright © 2017年 susuyan. All rights reserved.
//

import Foundation

print("Hello, World!")

// MARK: - 函数（Functions）
/*
 函数是用来完成特定任务的独立的代码块
 
 */

// MARK: - 函数的定义与调用（Defining and Calling Functions）
func sayHello(personName: String) -> String {
    let greeting = "Hello," + personName + "!"
    return greeting
}

print(sayHello(personName: "Anna"))
// MARK: - 函数参数与返回值（Function Parameters and Return Values）
func halfOpenRangeLength(start: Int, end: Int) -> Int {
    return end - start
}

print(halfOpenRangeLength(start: 1, end: 10))

// 无参函数
func sayHelloWorld() -> String {
    return "Hello world"
}
print(sayHelloWorld())

// 多重返回值函数
func minMax(array: [Int]) -> (min: Int, max: Int) {
    
    var currentMin = array[0]
    var currentMax = array[0]
    
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)

}

let bounds = minMax(array: [8, -6, 2, 109, 3, 71])
print("min is \(bounds.min) and max is \(bounds.max)")


func someFunction(argumentLabel parameterName: Int) {
    
}

func greet(person: String, from hometown: String) -> String {
    return "Hello \(person)! Glad you could visit from \(hometown)"
}

print(greet(person: "Bill", from: "Cupertino"))

//Default Parameter Values
func someFunction(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
    
}

someFunction(parameterWithoutDefault: 10)

// MARK: -  可变参数
/*
 一个可变参数可以接受一个或多个值
 函数调用时，你可以用可变参数来传入不确定数量的输入参数
 一个函数至多能有一个可变参数，而且它必须是参数表中最后的一个
 */

func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    
    return total / Double(numbers.count)
    
}

print(arithmeticMean(1,2,3,4,5))
print(arithmeticMean(3,8.25,18.76))

// MARK: - 输入输出参数
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
    
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now\(someInt), and anotherInt is now \(anotherInt)")

func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}

func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
    return a * b
}


// MARK: - 函数类型作为参数类型
/*
 你可以用（Int, Int） -> Int 这样的函数类型作为另一个函数的参数类型
 */
func printMathResult(_ mathFunction:(Int, Int) -> Int, _ a:Int, _ b: Int) {

    print("Result: \(mathFunction(a,b))")

}

printMathResult(addTwoInts, 3, 5)

// MARK: - 函数类型作为返回类型
func stepForward(_ input: Int) -> Int {
    return input + 1
}

func stepBackward(_ input: Int) -> Int {
    return input - 1
}

func chooseStepFunction(backward: Bool) -> (Int) ->(Int) {
    
    return backward ? stepBackward : stepForward
}

var currentValue = 3
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)

print("Counting to zero:")

while currentValue != 0 {
    print("\(currentValue)...")
    currentValue = moveNearerToZero(currentValue)
}

print("zero!")

// MARK: -  嵌套函数
func chooseStepFunctions(backward: Bool) -> (Int) -> Int{
    
    func stepForward(input: Int) -> Int {
        return input + 1
    }
    func stepBackward(input:Int) -> Int {
        return input - 1
    }
    
    return backward ? stepBackward : stepForward
    
}

var currentValues = -4
let moveNearerToZeros = chooseStepFunctions(backward: currentValue > 0)

while currentValues != 0 {
    print("\(currentValues)...")
    currentValues = moveNearerToZeros(currentValues)
}
print("zero!")

























