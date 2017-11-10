//
//  main.swift
//  LearnSwiftForClassAndStruct
//
//  Created by susuyan on 2017/11/10.
//  Copyright © 2017年 susuyan. All rights reserved.
//

import Foundation

print("Hello, World!")

// MARK: - 类和结构体
/*
 类和结构体是人们构建代码所用的一种通用且灵活的构造体
 为了在类和结构体中实现各种功能，我们必须要严格按照常量、变量以及函数所规定的语法规则来定义属性和添加方法
 Swift 并不要求你为自定义类和结构体去创建独立的接口和实现文件。
 系统将会自动生成面向其他代码的外部接口
 */

// MARK: - 类和结构体对比
/*
  共同之处：
     定义属性用于存储值
     定义方法用于提供功能
     定义附属脚本用于访问值
     定义构造器用于生成初始化值
     通过扩展以增加默认实现的功能
     符合协议以对某类提供标准功能
*/
/*
 类的附加功能：
     继承允许一个类继承另一个类的特征
     类型转换允许在运行时检查和解释一个类实例的类型
     解构器允许一个类实例释放任何其被分配的资源
     引用计数允许对一个类的多次引用
*/

struct Resolution {
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
    
}

let someResolution = Resolution()
let someVideoMode = VideoMode()

// MARK: - 结构体和枚举是值类型
/*
 值类型被赋予给一个变量，常数或本身被传递给一个函数的时候，实际上操作的是其的拷贝
 Swift 中，所有的机构体和枚举都是值类型
 这意味着它们的实例，以及实例中所包含的任何值类型属性
 在代码中传递的时候都会被复制
 */

let hd = Resolution(width: 1920, height: 1080)

// MARK: - 类是引用类型
/*
  与值类型不同，引用类型在被赋予到一个变量、常量或被传递到一个函数时，操作的是引用，其并不是拷贝。
  因此，引用的是已存在的是已存在的实例本身而不是拷贝
 */

let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0

print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")

// MARK: - 恒等运算符
/*
 因为类是引用类型，有可能有多个常量和变量在后台同时引用某一个类实例。
 所以恒等运算符，用于判定两个常量或者变量是否引用同一个类实例
 等价于 ===
 不等价于 !==
 */
if tenEighty === alsoTenEighty {
    print("tenTighty and alsoTenEighty refer to the same Resolution instance.")
}

/*
 ===   和 == 有什么不同
 
 “等价于” 表示两个类类型的常量或者变量引用于同一个类实例
 “等于”  表示两个实例的值“ 相等”  或 "相同"
 */

// MARK: - 指针
/*
 C、C++、Objective-C  这些语言使用指针来引用内存中的地址
 Swift 中与此类似，不同的是并不直接指向内存中的某个地址
 
 */

// MARK: - 类和结构体的选择
/*
 结构体实例总是通过值传递，类实例总是通过引用传递
 
 通用准则：（当符合一条或多条以下条件时，请考虑使用结构体）
     结构体的主要目的是用来封装少量相关简单数据值
     有理由预计一个结构体实例在赋值或传递时，封装的数据将会被拷贝而不是引用
     任何在结构体中储存的值类型属性，也将会被拷贝，而不是被引用
     结构体不需要去继承另一个已存在类型的属性或者行为
 */

// MARK: - 集合（Collection） 类型的赋值和拷贝行为
/*
 Swift 中字符串（String），数组（Array） 和字典（Dictionary） 类型均以结构体的形式实现。
 这意味着 Swift 集合类型数据被赋值给新的常量（或变量），或者被传入函数（或方法）中时，
 它们的值会发生拷贝行为（ 值传递方式）
 */

/*
 Objective-C 中字符串（NSString）, 数组（NSArray） 和字典(NSDictionary)类型均以类的形式实现
 这意味着 Objective-C 中集合类型在发生赋值或者传入函数（或方法）时，不会发生值拷贝，而是传递已存在实例的引用
 */

/*
 Swift 管理所有的值拷贝以确保性能最优化的性能，所以你也没有必要去避免以保证最有性能（实际赋值由系统掌握）
 */















