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
// func count(string: String) -> (vowels: Int, consonants: Int, others: Int) {
//
//    var vowels = 0, consonants = 0, others = 0
//    for character in string {
//        switch String(character).lowercased(){
//        case "a", "e", "i", "o", "u":
//            ++vowels
//        case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
//             "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
//            ++consonants
//        default:
//            ++others
//
//        }
//    }
//    return (vowels,consonants,others)
// }













