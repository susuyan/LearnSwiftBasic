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


func swapTwoInts( a: inout Int, b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}


