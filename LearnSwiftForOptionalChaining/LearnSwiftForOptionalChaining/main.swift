//
//  main.swift
//  LearnSwiftForOptionalChaining
//
//  Created by susuyan on 2017/11/13.
//  Copyright © 2017年 susuyan. All rights reserved.
//

import Foundation

print("Hello, World!")

/*
 可选链是一种可以请求和调用属性、方法及下标脚本的过程
 它的可选性体现于请求或调用的目标当前可能为空（nil）
 如果可选的目标有值，那么调用就会成功，相反如果选择的目标为空（nil），则这种调用将返回空（nil）
 多次请求或调用可以被链接在一起形成一个链，如果任何一个节点为空（nil）将导致整个链失效
 */

/*
 Swift的可选链和Objective-C中的消息为空有些相像，但是swift可以使用在任意类型中，并且失败与否可以被检测到
 */

class Person {
    
    var residence: Residence?
}

class Residence {
    var numberOfRooms = 1
    
}

let john = Person()

john.residence = nil


let roomCount = john.residence!.numberOfRooms









































