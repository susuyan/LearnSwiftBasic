//
//  main.swift
//  LearnSwiftForExtensions
//
//  Created by susuyan on 2017/11/14.
//  Copyright © 2017年 susuyan. All rights reserved.
//

import Foundation

print("Hello, World!")

/*
 扩展就是为一个有的类、结构体、枚举类型或者协议类型添加新功能。
 这包括在没有权限获取原始源代码的情况下扩展类型的能力（即逆向建模）
 扩展和Objective-C中的分类类似，不同的是 Swift 的扩展没有名字
 */

/*
 Swift 中的扩展可以
 添加计算型属性和计算静态属性
 定义实例方法和类型方法
 提供新的构造器
 定义下标
 定义和使用新的嵌套类型
 使一个已有类型符合某个协议
 */

// MARK: -  扩展语法
/*
extension SomeType {

}
 extension SomeType: SomeProtocol, AnotherProctocol{
 
 }
*/
// MARK: -  计算型属性

/*
  注意：扩展可以添加新的计算属性，但是不可以添加存储属性，也不可以向已有属性添加属性观察器
 */

extension Double {
    var km: Double { return self * 1_000.0 }
    var m : Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}

let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")
// 打印输出："One inch is 0.0254 meters"
let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")

// MARK: - 构造器
/*
 扩展可以向已有类型添加新的构造器。这可以让你扩展其它类型，将你自己的定制类型作为构造器参数
 或者提供该类型的原始实现中没有包含的额外初始化选项
 */

/*
 扩展能向类中添加新的便利构造器，但是它们不能向类中添加新的指定构造器或析构函数。
 指定构造器和析构函数必须总是由原始的类实现来提供
 */
struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}
let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
    size: Size(width: 5.0, height: 5.0))
extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
    size: Size(width: 3.0, height: 3.0))

// MARK: - 方法
/*
 扩展可以向已有类型添加新的实例方法和类型方法
 */
extension Int {
    func repetitions(task: () -> ()) {
        for _ in 0..<self {
        task()
        }
    }
}

3.repetitions {
    print("Goodbye!")
}

// MARK: - 修改实例方法
/*
 通过扩展添加的实例方法也可以修改该实例本身
 结构体和枚举类型中修改 self 或其属性的方法必须将该实例方法标注为 mutating
 */
extension Int {
    mutating func square() {
        self = self * self
    }
}
var someInt = 3
someInt.square()


//下标
/*
  扩展可以向一个已有类型添加新下标。
 */
extension Int {
    subscript(digitIndex: Int) -> Int {
        var digitIndex = digitIndex
        var decimalBase = 1
        while digitIndex > 0 {
            decimalBase *= 10
            digitIndex -= 1
        }
        return (self / decimalBase) % 10
    }
}

//746381295[0]
//// returns 5
//746381295[1]
//// returns 9
//746381295[2]
//// returns 2
//746381295[8]
//// returns 7”

// MARK: - 嵌套类型
/*
 扩展可以向已有的类、结构体和枚举添加新的嵌套类型
 */
extension Character {
    enum Kind {
        case Vowel, Consonant, Other
    }
    var kind: Kind {
        switch String(self).lowercased() {
        case "a", "e", "i", "o", "u":
            return .Vowel
        case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
             "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
            return .Consonant
        default:
            return .Other
        }
    }
}
















